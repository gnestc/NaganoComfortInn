class ByTimeOfYearPrice < ActiveRecord::Base
  attr_accessible :time_desc, :start_date, :end_date, :fixed_price_variation, :percent_variation
  has_many :invoice_details, as: :owner
end
