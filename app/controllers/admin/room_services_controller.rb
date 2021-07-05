require 'date'
module Admin
  class RoomServicesController < ApplicationController
    def show
      @room_service = RoomService.find(params[:id])
    end

    def index
      @room_services = RoomService.not_deleted
    end

    def new
      @rooms = Room.not_deleted
      @today = Date.today.strftime("%F")
    end

    def edit

    end

    def create
      @room_service = RoomService.new(params[:room_service])
      @room_service.save
      redirect_to admin_room_service_path(@room_service)
    end

    def update

    end

    def destroy
      @room_service = RoomService.find(params[:id])
      @room_service.update_column(:deleted_at, Date.today.to_formatted_s(:db))
      redirect_to admin_room_services_path
    end
  end
end