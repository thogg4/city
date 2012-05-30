class Admin::SitesController < ApplicationController
  def index
    @sites = Site.all
  end
  def show
    @site = Site.find(params[:id])
  end
  def new
    @site = Site.new
  end
  def create
    @site = Site.new(params[:site])
    if @site.save
      redirect_to admin_site_path(@site), :notice => "Site created"
    else
      redirect_to new_admin_site_path
      flash[:error] = "Something happened and the site was not created"
    end
  end
  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(params[:site])
      redirect_to admin_site_path(@site), :notice => "Site updated"
    else
      redirect_to admin_site_path(@site)
      flash[:error] = "Something happened and the site was not updated"
    end
  end
end
