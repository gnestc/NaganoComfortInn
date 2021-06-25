class Room < ActiveRecord::Base
  attr_accessible :is_available, :view_id, :room_type_id, :number
  has_many :reservations_rooms
  has_many :reservations, through: :reservations_rooms
  has_many :room_services
  has_many :invoice_details, as: :owner
  belongs_to :room_type
  belongs_to :view

  scope :search_date, ->(start_date, end_date) { joins(:reservations_rooms, reservations_rooms: :reservation)\
    .where("reservations.end_date < ?", start_date)\
    .where("reservations.start_date > ?", end_date)}
  scope :never_reserved, -> { where("id NOT IN (SELECT reservations_rooms.room_id FROM reservations_rooms)") }
  scope :by_view, ->(view_id) { where(view_id: view_id) if view_id.present? }
  scope :by_type, ->(type_id) { where(room_type_id: type_id) if type_id.present? }
end
