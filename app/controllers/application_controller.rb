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
    render_html(site, request.fullpath)
  end

  def render_html(site, title)
    logger.debug site.inspect
    page = site.pages.where(title: title).first
    if page
      render :inline => page.body
    else
      render :inline => "Page not found"
    end
  end

end
