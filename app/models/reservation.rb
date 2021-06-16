class Reservation < ActiveRecord::Base
  has_many :reservations_rooms
  has_many :rooms, through: :reservations_rooms
  has_many :invoices
end
