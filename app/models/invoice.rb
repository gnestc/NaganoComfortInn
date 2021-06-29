class Invoice < ActiveRecord::Base
  attr_accessible :customer_id, :reservation_id, :issue_date, :payment_reception_date
  has_many :invoice_details

  scope :not_deleted, -> { where(deleted_at: nil) }
end
