class InvoiceMailer < ActionMailer::Base
  default from: "carl.genest@semiweb.ca"

  def invoice_email(invoice)
    @invoice = invoice
    @url = admin_invoice_url(@invoice)
    mail(to: @invoice.customer.email, subject: 'Invoice') do |format|
      format.html
      format.text
    end
  end
end
