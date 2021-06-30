module Admin
  class RoomsController < ApplicationController
    def show
      @room = Room.find(params[:id])
    end

    def index
      @rooms = Room.not_deleted
    end

    def new
      @views = View.not_deleted
      @room_types = RoomType.not_deleted
    end

    def edit
      @room = Room.find(params[:id])
      @views = View.not_deleted
      @room_types = RoomType.not_deleted
    end

    def create
      @room = Room.new(params[:room])
      @room.save
      redirect_to admin_room_path(@room)
    end

    def update
      @room = Room.find(params[:id])
      @room.update_attributes(params[:room])
      redirect_to admin_room_path(@room)
    end

    def destroy
      @room = Room.find(params[:id])
      @room.update_column(:deleted_at, Date.today.to_formatted_s(:db))
      redirect_to admin_rooms_path
    end
  end
end