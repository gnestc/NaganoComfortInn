module Admin
  class ByDayOfWeekPricesController < ApplicationController
    def show
      @by_day_of_week_price = ByDayOfWeekPrice.find(params[:id])
    end

    def index

    end

    def new

    end

    def edit
      @by_day_of_week_price = ByDayOfWeekPrice.find(params[:id])
    end

    def create
      @by_day_of_week_price = ByDayOfWeekPrice.new(params[:by_day_of_week_price])
      @by_day_of_week_price.save
      redirect_to admin_by_day_of_week_price_path(@by_day_of_week_price)
    end

    def update
      @by_day_of_week_price = ByDayOfWeekPrice.find(params[:id])
      @by_day_of_week_price.update_attributes(params[:by_day_of_week_price])
      redirect_to admin_by_day_of_week_price_path(@by_day_of_week_price)
    end

    def destroy
      @by_day_of_week_price = ByDayOfWeekPrice.find(params[:id])
      @by_day_of_week_price.update_column(:deleted_at, Date.today.to_formatted_s(:db))
      redirect_to admin_change_prices_path
    end
  end
end