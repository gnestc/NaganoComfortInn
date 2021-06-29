class Customer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :credit_card_num
  has_many :reservations
  has_many :invoices

  scope :not_deleted, -> { where(deleted_at: nil) }
end
