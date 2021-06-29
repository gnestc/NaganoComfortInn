class Reservation < ActiveRecord::Base
  attr_accessible :customer_id, :start_date, :end_date, :special_request, :is_online_reservation
  has_many :reservations_rooms
  has_many :rooms, through: :reservations_rooms
  has_many :invoices
  belongs_to :customer
  accepts_nested_attributes_for :rooms

  scope :not_deleted, -> { where(deleted_at: nil) }
end
