class View < ActiveRecord::Base
  attr_accessible :view_desc, :view_fixed_price, :view_percent_variation
  has_many :rooms

  scope :not_deleted, -> { where(deleted_at: nil) }
end
