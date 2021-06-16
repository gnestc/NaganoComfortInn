class Room < ActiveRecord::Base
  attr_accessible :is_available, :view_id, :room_type_id
  has_many :reservations_rooms
  has_many :reservations, through: :reservations_rooms
  has_many :room_services
  has_many :invoice_details, as: :owner
end
