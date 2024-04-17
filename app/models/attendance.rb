class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :begin_at, presence: true
  validates :finish_at, presence: true
end
