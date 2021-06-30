module Admin
  class ByTimeOfYearPricesController < ApplicationController
    def show
      @by_time_of_year_price = ByTimeOfYearPrice.find(params[:id])
    end

    def index

    end

    def new

    end

    def edit
      @by_time_of_year_price = ByTimeOfYearPrice.find(params[:id])
    end

    def create
      @by_time_of_year_price = ByTimeOfYearPrice.new(params[:by_time_of_year_price])
      @by_time_of_year_price.save
      redirect_to admin_by_time_of_year_price_path(@by_time_of_year_price)
    end

    def update
      @by_time_of_year_price = ByTimeOfYearPrice.find(params[:id])
      @by_time_of_year_price.update_attributes(params[:@by_time_of_year_price])
      redirect_to admin_by_time_of_year_price_path(@by_time_of_year_price)
    end

    def destroy
      @by_time_of_year_price = ByTimeOfYearPrice.find(params[:id])
      @by_time_of_year_price.update_column(:deleted_at, Date.today.to_formatted_s(:db))
      redirect_to admin_change_prices_path
    end
  end
end