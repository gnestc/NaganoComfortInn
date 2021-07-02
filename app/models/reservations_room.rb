class ReservationsRoom < ActiveRecord::Base
  attr_accessible :reservation_id, :room_id
  belongs_to :reservation
  belongs_to :room

  scope :rooms_in_reservation, ->(res_id) { where(reservation_id: res_id) }

  validates :reservation, presence: { strict: true }
  validates :room, presence: { strict: true }
end
