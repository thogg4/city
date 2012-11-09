class Admin::SitesController < ApplicationController

  before_filter :should_be_logged_in
  before_filter :should_own_site, :except => [:index]

  def index
    if current_user.admin
      @sites = Site.all
    else
      @sites = current_user.sites
    end
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
      flash[:error] = "Something happened and the site was not created"
      redirect_to new_admin_site_path
    end
  end
  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(params[:site])
      redirect_to admin_site_path(@site), :notice => "Site updated"
    else
      flash[:error] = "Something happened and the site was not updated"
      redirect_to admin_site_path(@site)
    end
  end
end
