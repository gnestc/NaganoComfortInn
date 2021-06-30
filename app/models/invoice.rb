class Invoice < ActiveRecord::Base
  attr_accessible :customer_id, :reservation_id, :issue_date, :payment_reception_date
  has_many :invoice_details
  belongs_to :customer
  belongs_to :reservation

  scope :not_deleted, -> { where(deleted_at: nil) }

  validates :customer, presence: { strict: true }
  validates :reservation, presence: { strict: true }
end
