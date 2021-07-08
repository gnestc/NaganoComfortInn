class ApplicationController < ActionController::Base
  helper_method :price_by_period

  def price_by_period(start_date, end_date)
    period_total = 0
    (start_date..end_date).each do |day|
      day_of_week = day.strftime("%A")
      day_prices = ByDayOfWeekPrice.not_deleted.where(day_desc: day_of_week)
      period_total += day_prices.first.fixed_price_variation
      times = ByTimeOfYearPrice.not_deleted.in_range(day)
      times.each do |time|
        period_total += time.fixed_price_variation
      end
    end
    return period_total
  end
end
