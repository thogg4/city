class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_site
    site = if params[:site_id]
      Site.get_by_id(params[:site_id])
    else
      Site.get(request)
    end
    logger.info request.host
    logger.info request.fullpath
    if site
      render_html(site, request.fullpath.sub("/", ""))
    else
      site_not_found
    end
  end

  def render_html(site, path)
    logger.debug site.inspect
    page = site.pages.where(path: path).first
    if page
      if page.layout # render the page within the layout
        html = $redis.get(page.layout.redis_hash).sub("{{ page }}", $redis.get(page.redis_hash))
        render :inline => html
      else # render just a page with no layout

        redis_render = $redis.get(page.redis_hash)
        if !redis_render
          page.create_render
        end
        logger.info "Rendering page from Redis"
        render :inline => redis_render

      end
    else
      render :inline => "Page not found"
    end
  end

  def site_not_found
    render :inline => "Site not found"
  end


  def get_site
    @site = Site.find(params[:site_id])
  end

  def should_be_logged_in
    if !current_user
      flash[:error] = "You have to be logged in to get to this page"
      redirect_to admin_login_path
    end
  end

  def should_own_site
    if !current_user.admin
      site = params[:site_id] ? Site.find(params[:site_id]) : Site.find(params[:id])
      if site.user_id != current_user.id
        flash[:error] = "You do not have access to that page"
        redirect_to admin_sites_path
      end
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

end
