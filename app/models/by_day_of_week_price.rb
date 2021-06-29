class ByDayOfWeekPrice < ActiveRecord::Base
  attr_accessible :day_desc, :fixed_price_variation, :percent_variation
  has_many :invoice_details, as: :owner

  scope :not_deleted, -> { where(deleted_at: nil) }
end
