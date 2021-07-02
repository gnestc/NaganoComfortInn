class ByTimeOfYearPrice < ActiveRecord::Base
  attr_accessible :time_desc, :start_date, :end_date, :fixed_price_variation, :percent_variation
  has_many :invoice_details, as: :owner

  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :in_range, ->(date) { where("start_date <= ? AND end_date >= ?", date, date) }
end
