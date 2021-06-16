class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
  end

  def index
    @rooms = Room.all
  end

  def new

  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(params[:room])
    @room.save
    redirect_to room_path(@room)
  end

  def update
    @room = Room.find(params[:id])
    @room.update_attributes(params[:room])
    redirect_to @room
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end
end