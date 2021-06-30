require 'date'
module Admin
  class ReservationsController < ApplicationController
    def show
      @reservation = Reservation.find(params[:id])
    end

    def index
      @reservations = Reservation.not_deleted
      @invoices = Invoice.not_deleted
    end

    def edit
      @reservation = Reservation.find(params[:id])
      @customers = Customer.not_deleted
      @rooms = Room.not_deleted
    end

    def update
      @reservation = Reservation.find(params[:id])
      @reservation.update_attributes(params[:reservation])
      @reservations_room = ReservationsRoom.find(params[:room_id])
      redirect_to admin_reservation_path(@reservation)
    end

    def destroy
      @reservation = Reservation.find(params[:id])
      @reservation.update_column(:deleted_at, Date.today.to_formatted_s(:db))
      redirect_to admin_reservations_path
    end

    def search
      @rooms = Room.not_deleted
    end
  end
end
