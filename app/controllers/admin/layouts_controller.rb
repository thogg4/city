class Admin::LayoutsController < ApplicationController

  before_filter :get_site, :should_be_logged_in, :should_own_site

  def index
    @layouts = @site.layouts
  end
  def show
    @layout = Layout.find(params[:id])
  end
  def new
    @layout = Layout.new
  end
  def create
    @layout = @site.layouts.build(params[:layout])
    if @layout.save
      redirect_to admin_site_layout_path(@site, @layout), :notice => "Layout created"
    else
      flash[:error] = "Something bad happened and the layout was not created"
      redirect_to new_admin_site_layout_path(@site)
    end
  end
  def update
    @layout = Layout.find(params[:id])
    if @layout.update_attributes(params[:layout])
      redirect_to admin_site_layout_path(@site, @layout), :notice => "Layout updated"
    else
      flash[:error] = "Something bad happened and the layout was not updated"
      redirect_to admin_site_layout_path(@site, @layout)
    end
  end
end
