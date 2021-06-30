require 'date'
class Reservation < ActiveRecord::Base
  attr_accessible :customer_id, :start_date, :end_date, :special_request, :is_online_reservation
  has_many :reservations_rooms
  has_many :rooms, through: :reservations_rooms
  has_many :invoices
  belongs_to :customer
  accepts_nested_attributes_for :rooms

  scope :not_deleted, -> { where(deleted_at: nil) }

  validates :start_date, presence: { strict: true }, if: -> {:start_date.to_s >= Date.today.strftime("%Y-%m-%d")}
  validates :end_date, presence: { strict: true }, if: -> {:end_date.to_s > Date.today.strftime("%Y-%m-%d")}
  validates :customer, presence: { strict: true }
end
