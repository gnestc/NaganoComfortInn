class ViewsController < ApplicationController
  def show
    @view = View.find(params[:id])
  end

  def index

  end

  def new

  end

  def edit
    @view = View.find(params[:id])
  end

  def create
    @view = View.new(params[:view])
    @view.save
    redirect_to view_path(@view)
  end

  def update
    @view = View.find(params[:id])
    @view.update_attributes(params[:view])
    redirect_to @view
  end

  def destroy
    @view = View.find(params[:id])
    @view.destroy
    redirect_to change_prices_path
  end
end