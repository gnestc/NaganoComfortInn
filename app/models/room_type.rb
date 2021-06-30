class RoomType < ActiveRecord::Base
  attr_accessible :type_desc, :type_fixed_price, :type_percent_variation
  has_many :rooms

  scope :not_deleted, -> { where(deleted_at: nil) }

  validates :view_desc, presence: { strict: true }
end
