class CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def index
    @customers = Customer.all
  end

  def new

  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(params[:customer])
    @customer.save
    redirect_to customer_path(@customer)
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update_attributes(params[:customer])
    redirect_to @customer
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json
      format.js { render layout: false }
    end
  end
end