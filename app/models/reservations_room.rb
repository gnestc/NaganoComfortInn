class ReservationsRoom < ActiveRecord::Base
  attr_accessible :reservation_id, :room_id
  belongs_to :reservation
  belongs_to :room

  validates :reservation, presence: { strict: true }
  validates :room, presence: { strict: true }
end
