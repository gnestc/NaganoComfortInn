class Report < ActiveRecord::Base
  has_many :room_services

  scope :not_deleted, -> { where(deleted_at: nil) }
end
