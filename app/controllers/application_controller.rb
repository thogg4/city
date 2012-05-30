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
      if page.layout
        html = page.layout.body.sub("{{ page }}", page.body)
        render :inline => html
      else
        render :inline => page.body
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



end
