class Attendance < ApplicationRecord
  has_one :message
  accepts_nested_attributes_for :message
  belongs_to :user
  has_one :attendance_to_change, class_name: 'Message', foreign_key: 'to_change', dependent: :destroy


  validates :timestamp, presence: true
  validates :status, inclusion: { in: ['begin', 'finish', 'modification_request', 'settled'],
                                  message: "%{value} is not a valid status" },
                      presence: true
  
  def status_to_japanese
    case status
    when "begin"
      "出勤"
    when "finish"
      "退勤"
    when "modification_request"
      "修正依頼"
    when "settled"
      "修正済み"
    else
      status
    end
  end
  def display_selection
    status_txt =
    "#{timestamp.strftime('%Y-%m-%d %H:%M:%S')} - #{status_to_japanese}"
  end
end
