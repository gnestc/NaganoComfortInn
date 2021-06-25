class RoomTypesController < ApplicationController
  def show
    @room_type = RoomType.find(params[:id])
  end

  def index

  end

  def new

  end

  def edit
    @room_type = RoomType.find(params[:id])
  end

  def create
    @room_type = RoomType.new(params[:room_type])
    @room_type.save
    redirect_to room_type_path(@room_type)
  end

  def update
    @room_type = RoomType.find(params[:id])
    @room_type.update_attributes(params[:room_type])
    redirect_to @room_type
  end

  def destroy
    @room_type = RoomType.find(params[:id])
    @room_type.destroy
    redirect_to change_prices_path
  end
end