class RoomService < ActiveRecord::Base
  belongs_to :room
  belongs_to :report
end
