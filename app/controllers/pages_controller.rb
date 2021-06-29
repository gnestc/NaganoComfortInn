class PagesController < ApplicationController
  def home
  end

  def results
    @views = View.all
    @room_types = RoomType.all

    @rooms = Room.search_date(params[:reservation][:start_date], params[:reservation][:end_date])\
      .by_view(params[:reservation][:view_id]).by_type(params[:reservation][:room_type_id])
    @rooms += Room.never_reserved\
      .by_view(params[:reservation][:view_id]).by_type(params[:reservation][:room_type_id])
  end

  def confirmation
    puts(params.inspect)
    @room = Room.find(params[:room_id])
  end

  def confirmed
    # @reservation = Reservation.new(params[:reservation])
    # @reservation.save
    # @reservations_room = ReservationsRoom.new(reservation_id: @reservation.id, room_id: params[:reservations_rooms][:room_id])
    # @reservations_room.save
    # redirect_to reservation_path(@reservation)
  end
end
