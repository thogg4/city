class Admin::IncludesController < ApplicationController

  before_filter :get_site, :should_be_logged_in, :should_own_site

  def index
    @includes = @site.includes
  end
  def show
    @include = Include.find(params[:id])
  end
  def new
    @include = Include.new
  end
  def create
    @include = @site.includes.build(params[:include])
    if @include.save
      redirect_to admin_site_include_path(@site, @include), :notice => "Include created"
    else
      redirect_to new_admin_site_include_path(@site)
      flash[:error] = "Something bad happened and the include was not created"
    end
  end
  def update
    @include = Include.find(params[:id])
    if @include.update_attributes(params[:include])
      redirect_to admin_site_include_path(@site, @include), :notice => "Include updated"
    else
      redirect_to admin_site_include_path(@site, @include)
      flash[:error] = "Something bad happened and the include was not updated"
    end
  end
end
