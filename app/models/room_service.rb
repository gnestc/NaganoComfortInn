class RoomService < ActiveRecord::Base
  attr_accessible :room_id, :created_at
  belongs_to :room

  scope :not_deleted, -> { where(deleted_at: nil) }
end
