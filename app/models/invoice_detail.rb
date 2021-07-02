class InvoiceDetail < ActiveRecord::Base
  attr_accessible :invoice_id, :owner_id, :owner_type
  belongs_to :owner, polymorphic: true
end
