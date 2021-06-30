module Admin
  class ChangePricesController < ApplicationController
    def index
      @views = View.not_deleted
      @room_types = RoomType.not_deleted
      @by_time_of_year_prices = ByTimeOfYearPrice.not_deleted
      @by_day_of_week_prices = ByDayOfWeekPrice.not_deleted
    end
  end
end