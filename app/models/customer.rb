class Customer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :phone, :email, :credit_card_num
  has_many :reservations
  has_many :invoices

  scope :not_deleted, -> { where(deleted_at: nil) }

  @VALID_EMAIL_REGEX = /^.+@.+$/

  validates :first_name, presence: { strict: true }
  validates :last_name, presence: { strict: true }
  validates :phone, presence: { strict: true }, :length => { :minimum => 10, :maximum => 15 }
  validates :email, format: { with: @VALID_EMAIL_REGEX, uniqueness: { case_sensitive: false, scope: :not_deleted}, length: { minimum: 4, maximum: 254 }, strict: true}
  validates :credit_card_num, numericality: { strict: true }, :length => { :minimum => 16, :maximum => 16, strict: true }
end
