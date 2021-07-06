require 'date'
class PagesController < ApplicationController
  def home
    @reservation = Reservation.new
  end

  def results
    if params[:res][:start_date] < Date.today.strftime("%Y-%m-%d")
      redirect_to :back, flash: {danger: "Start date cannot be sooner than today"}
    elsif params[:res][:end_date] <= Date.today.strftime("%Y-%m-%d")
      redirect_to :back, flash: {danger: "End date cannot be sooner than tomorrow"}
    end

    @price_by_period = price_by_period(params[:res][:start_date], params[:res][:end_date])

    @views = View.not_deleted
    @room_types = RoomType.not_deleted

    @rooms = Room.uniq.not_deleted.never_reserved\
        .by_view(params[:res][:view_id]).by_type(params[:res][:room_type_id])
    @rooms += Room.uniq.not_deleted.search_date(params[:res][:start_date], params[:res][:end_date])\
        .by_view(params[:res][:view_id]).by_type(params[:res][:room_type_id])

    @enough_room_msg = nil
    if params[:res][:guests].present?
      @room_qty_asked = (params[:res][:guests].to_f/2.0).ceil
      @rooms.count < @room_qty_asked ? @enough_room_msg = "Nombre de chambres insuffisant" : @enough_room_msg = nil
    end
  end

  def confirmation
    if params[:start_date] < Date.today.strftime("%Y-%m-%d")
      redirect_to :back, flash: {danger: "Start date cannot be sooner than today"}
    elsif params[:end_date] <= Date.today.strftime("%Y-%m-%d")
      redirect_to :back, flash: {danger: "End date cannot be sooner than tomorrow"}
    end

    @view = View.find(params[:view_id]) if params[:view_id].present?
    @room_type = RoomType.find(params[:room_type_id]) if params[:room_type_id].present?
    @room = Room.find(params[:room_id])

    @rooms = Room.uniq.not_deleted.never_reserved\
        .by_view(@room.view_id).by_type(@room.room_type_id).not_selected(@room.id)
    @rooms += Room.uniq.not_deleted.search_date(params[:start_date], params[:end_date])\
        .by_view(@room.view_id).by_type(@room.room_type_id).not_selected(@room.id)

    @enough_room_msg = nil
    @rooms_to_reserve = {}
    @rooms_to_reserve[0] = @room.number

    if params[:guests].present?
      @room_qty_asked = (params[:guests].to_f/2.0).ceil
      @rooms.count+1 < @room_qty_asked ? @enough_room_msg = "Nombre de chambres insuffisant" : @enough_room_msg = nil

      (0..@room_qty_asked-2).each do |i|
        @rooms_to_reserve[i+1] = @rooms[i][:number]
      end
    end
  end

  def confirmed
    unless params[:res][:customer_id] =~ /^.+@.+$/
      redirect_to :back, flash: { danger: "Courriel invalide" } and return
    end

    @reservation = Reservation.new(start_date: params[:res][:start_date], end_date: params[:res][:end_date])
    customer = Customer.find_by_email(params[:res][:customer_id])
    @reservation.customer_id = customer.id
    @reservation.save

    rooms_to_reserve = params[:roomsToReserve]
    rooms_to_reserve.each do |room|
      @room = Room.find_by_number(room)
      @reservations_room = ReservationsRoom.new(reservation_id: @reservation.id, room_id: @room.id)
      @reservations_room.save
    end
  end

  private
    def price_by_period(start_date, end_date)
      period_total = 0
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      (start_date..end_date).each do |day|
        day_of_week = day.strftime("%A")
        day_prices = ByDayOfWeekPrice.not_deleted.where(day_desc: day_of_week)
        period_total += day_prices.first.fixed_price_variation
        times = ByTimeOfYearPrice.not_deleted.in_range(day)
        times.each do |time|
          period_total += time.fixed_price_variation
        end
      end
      return period_total
    end
end
