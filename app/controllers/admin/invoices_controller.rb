# encoding: UTF-8
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
      if !(params[:invoice][:reservation_id].present?)
        flash[:danger] = "Entrez un numéro de réservation"
        redirect_to :back and return
      elsif !(params[:invoice][:customer_id].present?)
        flash[:danger] = "Entrez le numéro du client"
        redirect_to :back and return
      end

      @invoice = Invoice.new(params[:invoice])

      room_list = ReservationsRoom.rooms_in_reservation(@invoice.reservation_id)
      reservation = Reservation.select([:start_date, :end_date]).where(id: @invoice.reservation_id)

      @price_by_period = price_by_period(reservation.first.start_date, reservation.first.end_date) #Application Controller Method

      @subtotal = 0
      room_list.each do |room|
        @subtotal += @price_by_period + room.room.room_type.type_fixed_price + room.room.view.view_fixed_price
      end

      @invoice.subtotal = @subtotal
      @invoice.save

      room_list.each do |room|
        @invoice_detail = InvoiceDetail.new(invoice_id: @invoice.id, owner_id: room.room.id, owner_type: "room")
        @invoice_detail.save
      end

      (reservation.first.start_date..reservation.first.end_date).each do |day|
        day_of_week = day.strftime("%A")
        day_info = ByDayOfWeekPrice.not_deleted.where(day_desc: day_of_week)
        @invoice_detail = InvoiceDetail.new(invoice_id: @invoice.id, owner_id: day_info.first.id, owner_type: "day")
        @invoice_detail.save

        times = ByTimeOfYearPrice.not_deleted.in_range(day)
        times.each do |time|
          @invoice_detail = InvoiceDetail.new(invoice_id: @invoice.id, owner_id: time.id, owner_type: "time")
          @invoice_detail.save
        end
      end

      if @invoice.save && @invoice_detail.save
        flash[:success] = "Envoi par courriel réussi!"
      end

      respond_to do |format|
        InvoiceMailer.invoice_email(@invoice).deliver
        format.html { redirect_to admin_invoice_path(@invoice) }
      end
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