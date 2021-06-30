module Admin
  class InvoicesController < ApplicationController
    def show
      @invoice = Invoice.find(params[:id])
    end

    def index

    end

    def new

    end

    def edit
      @invoice = Invoice.find(params[:id])
    end

    def create
      @invoice = Invoice.new(params[:invoice])
      @invoice.save
      redirect_to admin_invoice_path(@invoice)
    end

    def update
      @invoice = Invoice.find(params[:id])
      @invoice.update_attributes(params[:invoice])
      redirect_to admin_invoice_path(@invoice)
    end

    def destroy
      @invoice = Invoice.find(params[:id])
      @invoice.update_column(:deleted_at, Date.today.to_formatted_s(:db))
      redirect_to admin_reservations_path
    end
  end
end