require 'date'

class ReservationsController < ApplicationController
  def show
    @reservation = Reservation.find(params[:id])
  end

  def index
    @reservations = Reservation.all
  end

  def new
    @customers = Customer.all
    @rooms = Room.all
    @views = View.all
    @room_types = RoomType.all
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @customers = Customer.all
    @rooms = Room.all
  end

  def create
    @reservation = Reservation.new(params[:reservation])
    @reservation.save
    @reservations_room = ReservationsRoom.new(reservation_id: @reservation.id, room_id: params[:reservations_rooms][:room_id])
    @reservations_room.save
    redirect_to reservation_path(@reservation)
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(params[:reservation])
    @reservations_room = ReservationsRoom.find(params[:room_id])
    redirect_to @reservation
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path
  end

  def search
    @rooms = Room.all
  end

  def results
    @views = View.all
    @room_types = RoomType.all

    @rooms = Room.search_date(params[:reservation][:start_date], params[:reservation][:end_date])\
      .by_view(params[:reservation][:view_id]).by_type(params[:reservation][:room_type_id])
    @rooms += Room.never_reserved\
      .by_view(params[:reservation][:view_id]).by_type(params[:reservation][:room_type_id])
  end
end
