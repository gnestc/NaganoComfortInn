class ReservationsRoom < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :room
end
