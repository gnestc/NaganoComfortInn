require 'date'
class PagesController < ApplicationController
  def home
    @reservation = Reservation.new
  end

  def results
    raise "Error : Start date cannot be sooner than today " if params[:reservation][:start_date] < Date.today.strftime("%Y-%m-%d")
    raise "Error : End date cannot be sooner than tomorrow " if params[:reservation][:end_date] <= Date.today.strftime("%Y-%m-%d")

    @views = View.not_deleted
    @room_types = RoomType.not_deleted

    @rooms = Room.uniq.not_deleted.never_reserved\
      .by_view(params[:reservation][:view_id]).by_type(params[:reservation][:room_type_id])

    @rooms += Room.uniq.not_deleted.search_date(params[:reservation][:start_date], params[:reservation][:end_date])\
      .by_view(params[:reservation][:view_id]).by_type(params[:reservation][:room_type_id])

  end

  def confirmation
    @room = Room.find(params[:room_id])
  end

  def confirmed
    @room = Room.find(params[:res][:room_id])
    @reservation = Reservation.new(start_date: params[:res][:start_date], end_date: params[:res][:end_date])
    customer = Customer.find_by_email(params[:res][:customer_id])
    @reservation.customer_id = customer.id
    @reservation.save
    @reservations_room = ReservationsRoom.new(reservation_id: @reservation.id, room_id: @room.id)
    @reservations_room.save
  end
end
