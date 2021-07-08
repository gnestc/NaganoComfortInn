class InvoiceDetail < ActiveRecord::Base
  attr_accessible :invoice_id, :owner_id, :owner_type
  belongs_to :owner, polymorphic: true

  scope :details_in_invoice, ->(inv_id, own_type) { where(invoice_id: inv_id, owner_type: own_type) }
end
