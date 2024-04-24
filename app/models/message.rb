class Message < ApplicationRecord
  belongs_to :attendance
  has_one :user, through: :attendance
  belongs_to :attendance_to_change, class_name: 'Attendance', optional: true
  belongs_to :receiver, class_name: 'User'
  default_scope -> { order(created_at: :desc) }

  validates :receiver_id, presence: true
  validates :content, presence: true, length: { maximum: 20 }
  validate :both_attendance_id_must_belong_to_same_user, if: -> { attendance.status == 'begin_request' || attendance.status == 'finish_request' }
  validate :content_must_include_specific_word, if: -> { attendance.status == "finish" }

  private
    def both_attendance_id_must_belong_to_same_user
      if attendance.user_id != attendance_to_change.user_id
        errors.add(:attendance_to_change, "他のユーザーの出退勤の変更申請はできません")
      end
    end
      
    def content_must_include_specific_word
      unless content &.include?("ありがとう")
        errors.add(:content, "「ありがとう」という言葉を含めてください！")
      end
    end
end
