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
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @customers = Customer.all
  end

  def create
    @reservation = Reservation.new(params[:reservation])
    @reservation.reservations_rooms.build
    @reservation.save
    redirect_to reservation_path(@reservation)
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(params[:reservation])
    redirect_to @reservation
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path
  end
end