class Attendance < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :begin_at, presence: true
  validates :finish_at, presence: true
  validate :finish_time_after_begin_time
end