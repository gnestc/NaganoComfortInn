# encoding: UTF-8
module Admin
  class CustomersController < ApplicationController
    def show
      @customer = Customer.find(params[:id])
    end

    def index
      @customers = Customer.not_deleted
    end

    def new
      respond_to do |format|
        format.html { redirect_to admin_customers_url }
        format.json
        format.js { render layout: false }
      end
    end

    def edit
      @customer = Customer.find(params[:id])
    end

    def create
      @customer = Customer.new(params[:customer])
      if params[:customer][:first_name].present? && params[:customer][:last_name].present? &&
        params[:customer][:email].present? && params[:customer][:credit_card_num].present? &&
        params[:customer][:phone].present?
        @customer.save
        flash.now[:success] = "Client enregistré avec succès!"
      else
        flash.now[:danger] = "Vérifiez la conformité de chaque champ."
      end

      # render 'admin/customers/create.js.erb', layout: false
      respond_to do |format|
        format.html { redirect_to admin_customers_url }
        format.json
        format.js { render layout: false }
      end
    end

    def update
      @customer = Customer.find(params[:id])
      @customer.update_attributes(params[:customer])
      redirect_to admin_customer_path(@customer)
    end

    def destroy
      @customer = Customer.find(params[:id])
      @customer.update_column(:deleted_at, Date.today.to_formatted_s(:db))
      respond_to do |format|
        format.html { redirect_to admin_customers_url }
        format.json
        format.js { render layout: false }
      end
    end
  end
end