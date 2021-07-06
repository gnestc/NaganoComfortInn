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

      room_list = ReservationsRoom.rooms_in_reservation(@invoice.reservation_id)
      reservation = Reservation.select([:start_date, :end_date]).where(id: @invoice.reservation_id)

      start_date = reservation.first.start_date
      end_date = reservation.first.end_date
      @period_total = 0

      (start_date..end_date).each do |day|
        day_of_week = day.strftime("%A")
        day_prices = ByDayOfWeekPrice.not_deleted.where(day_desc: day_of_week)
        @period_total += day_prices.first.fixed_price_variation
        times = ByTimeOfYearPrice.not_deleted.in_range(day)
        times.each do |time|
          @period_total += time.fixed_price_variation
        end
      end
      @subtotal = 0
      room_list.each do |room|
        @subtotal += @period_total + room.room.room_type.type_fixed_price + room.room.view.view_fixed_price
      end

      @invoice.subtotal = @subtotal
      @invoice.save

      room_list.each do |room|
        @invoice_detail = InvoiceDetail.new(invoice_id: @invoice.id, owner_id: room.id, owner_type: "room")
        @invoice_detail.save
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