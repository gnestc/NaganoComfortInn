# encoding: UTF-8
require 'date'
class PagesController < ApplicationController
  def home
    @reservation = Reservation.new
  end

  def results
    date_check(params[:res][:start_date], params[:res][:end_date])

    start_date = Date.parse(params[:res][:start_date])
    end_date = Date.parse(params[:res][:end_date])
    @price_by_period = price_by_period(start_date, end_date) #Application Controller Method

    @views = View.not_deleted
    @room_types = RoomType.not_deleted

    @rooms = Room.uniq.not_deleted.never_reserved\
        .by_view(params[:res][:view_id]).by_type(params[:res][:room_type_id])
    @rooms += Room.uniq.not_deleted.search_date(params[:res][:start_date], params[:res][:end_date])\
        .by_view(params[:res][:view_id]).by_type(params[:res][:room_type_id])

    guests_check(false, params[:res][:guests])
  end

  def confirmation
    date_check(params[:res][:start_date], params[:res][:end_date])

    @view = View.find(params[:res][:view_id]) if params[:res][:view_id].present?
    @room_type = RoomType.find(params[:res][:room_type_id]) if params[:res][:room_type_id].present?
    @room = Room.find(params[:res][:room_id])

    @rooms = Room.uniq.not_deleted.never_reserved\
        .by_view(@room.view_id).by_type(@room.room_type_id).not_selected(@room.id)
    @rooms += Room.uniq.not_deleted.search_date(params[:start_date], params[:end_date])\
        .by_view(@room.view_id).by_type(@room.room_type_id).not_selected(@room.id)

    @rooms_to_reserve = {}
    @rooms_to_reserve[0] = @room.number

    guests_check(true, params[:res][:guests])
  end

  def confirmed
    unless params[:res][:customer_id] =~ /^.+@.+$/
      flash[:danger]= "Courriel invalide"
      redirect_to :back and return
    end

    @reservation = Reservation.new(start_date: params[:res][:start_date], end_date: params[:res][:end_date])
    customer = Customer.find_by_email(params[:res][:customer_id])
    @reservation.customer_id = customer.id
    @reservation.save

    rooms_to_reserve = params[:roomsToReserve]
    rooms_to_reserve.each do |room|
      @room = Room.find_by_number(room)
      @reservations_room = ReservationsRoom.new(reservation_id: @reservation.id, room_id: @room.id)
      @reservations_room.save
    end

    if @reservation.save && @reservations_room.save
      flash.now[:success]= "Réservation enregistrée avec succès!"
    else
      flash.now[:danger]= "La réservation n'a pas été enregistrée correctement. Une erreur est survenue."
    end
  end
  private
    def date_check(start_date, end_date)
      if start_date < Date.today.strftime("%Y-%m-%d")
        flash[:danger] = "La date d'arrivée ne peut précéder la date d'aujourd'hui."
        redirect_to :back
      elsif end_date <= Date.today.strftime("%Y-%m-%d")
        flash[:danger] = "La date de départ ne peut précéder la date de demain."
        redirect_to :back
      end
    end

  def guests_check(room_clicked, guests)
    if guests.present?
      if guests.to_f < 1
        flash[:danger] = "Personnes : Veuillez entrer une valeur strictement positive."
        redirect_to :back and return
      end
      room_qty_asked = (params[:res][:guests].to_i/2.0).ceil

      if @rooms.count < room_qty_asked && room_clicked == false
        flash.now[:danger] = "Nombre de chambres insuffisant à la quantité de personnes insérée (max. 2 par chambre)"
      elsif @rooms.count+1 < room_qty_asked && room_clicked == true
        flash.now[:danger] = "Manque de chambres: Le nombre de chambres a été ajusté au maximum disponible."
        room_qty_asked = @rooms.count+1
      else
        flash.now[:success] = "Nombre de chambres suffisant à la quantité de personnes insérée (max. 2 par chambre)"
      end

      if room_qty_asked > 1 && room_clicked == true
        (0..room_qty_asked-2).each do |i|
          @rooms_to_reserve[i+1] = @rooms[i][:number]
        end
      end
    end
  end
end
