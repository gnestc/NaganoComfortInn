class Report < ActiveRecord::Base
  attr_accessible :issue_date, :daily_occupancy_rate, :total_daily_income

  scope :not_deleted, -> { where(deleted_at: nil) }
end
