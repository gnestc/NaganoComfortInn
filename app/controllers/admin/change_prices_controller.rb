module Admin
  class ChangePricesController < ApplicationController
    def index
      @views = View.not_deleted
      @room_types = RoomType.not_deleted
    end
  end
end