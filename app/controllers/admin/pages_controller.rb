class Admin::PagesController < ApplicationController

  before_filter :get_site

  def index
    @pages = @site.pages
  end
  def show
    @page = Page.find(params[:id])
  end
  def new
    @page = Page.new
  end
  def create
    @page = @site.pages.build(params[:page])
    if @page
      redirect_to admin_site_page_path(@site, @page), :notice => "Page created"
    else
      redirect_to new_admin_site_page_path(@site)
      flash[:error] = "Something bad happened and the page was not created"
    end
  end
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to admin_site_page_path(@site, @page), :notice => "Page Saved"
    else
      redirect_to admin_site_page_path(@site, @page)
      flash[:error] = "Something bad happened, and the page was not saved"
    end
  end

  private
end
