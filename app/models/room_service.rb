class RoomService < ActiveRecord::Base
  belongs_to :room
  belongs_to :report

  scope :not_deleted, -> { where(deleted_at: nil) }
end
