class Room < ActiveRecord::Base
  attr_accessible :is_available, :view_id, :room_type_id, :number
  has_many :reservations_rooms
  has_many :reservations, through: :reservations_rooms
  has_many :room_services
  has_many :invoice_details, as: :owner
  belongs_to :room_type
  belongs_to :view

  scope :search_date, ->(start_date, end_date) { joins(:reservations_rooms, reservations_rooms: :reservation)\
    .where("(reservations.end_date <= ? OR reservations.start_date >= ?"+\
            " OR (reservations.start_date IS NULL AND reservations.end_date IS NULL))"+\
            " OR (reservations.deleted_at IS NOT NULL)", start_date, end_date) }
  scope :never_reserved, -> { where("id NOT IN (SELECT reservations_rooms.room_id FROM reservations_rooms)") }
  scope :by_view, ->(view_id) { where(view_id: view_id) if view_id.present? }
  scope :by_type, ->(type_id) { where(room_type_id: type_id) if type_id.present? }
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :not_selected, ->(room_id) { where("rooms.id <> ?", room_id) }

  validates :number, presence: { strict: true }, uniqueness: { strict: true }
  validates :room_type, presence: { strict: true }
  validates :view, presence: { strict: true }
end
