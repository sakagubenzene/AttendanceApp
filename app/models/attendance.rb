class Attendance < ApplicationRecord
  has_one :message
  belongs_to :user
  has_one :attendance_to_change, class_name: 'Message', foreign_key: 'to_change', dependent: :destroy


  validates :timestamp, presence: true
  validates :status, inclusion: { in: ['begin', 'finish', 'begin_request', 'finish_request', 'settled'],
                                  message: "%{value} is not a valid status" },
                      presence: true
end
