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
    @rooms = Room.all
    @customers = Customer.all
    @views = View.all
    @room_types = RoomType.all

    if(params.has_key?(:view_id))
      @test = "Hola"
    end

    @results = Room.where("rooms.id NOT IN (SELECT reservations_rooms.room_id FROM reservations_rooms)")
    @results += Room.joins(:reservations_rooms, reservations_rooms: :reservation)\
      .where("reservations.end_date < ? OR reservations.end_date IS NULL", params[:start_date])\
      .where("reservations.start_date > ? OR reservations.start_date IS NULL", params[:end_date])
    @results = @results.where(view_id: params[:view_id]) if(params.has_key?(:view_id))
    @results = @results.where(room_type_id: params[:room_type_id]) if(params.has_key?(:room_type_id))
  end
end
