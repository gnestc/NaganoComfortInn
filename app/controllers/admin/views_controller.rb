# encoding: UTF-8
require 'date'

module Admin
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
      unless params[:view][:view_desc].present? && (params[:view][:view_fixed_price].present? || params[:view][:view_percent_variation].present?)
        flash[:danger] = "Insérer un prix et une description."
        redirect_to :back and return
      end

      @view = View.new(params[:view])
      @view.save
      flash[:success] = "Vue créée avec succès!"
      redirect_to admin_view_path(@view)
    end

    def update
      @view = View.find(params[:id])
      @view.update_attributes(params[:view])
      redirect_to admin_view_path(@view)
    end

    def destroy
      @view = View.find(params[:id])
      @view.update_column(:deleted_at, Date.today.to_formatted_s(:db))
      redirect_to admin_change_prices_path
    end
  end
end