class RoomType < ActiveRecord::Base
  attr_accessible :type_desc, :type_fixed_price, :type_percent_variation
  has_many :rooms
end
