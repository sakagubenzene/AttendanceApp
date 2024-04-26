class Message < ApplicationRecord
  belongs_to :attendance
  delegate :user, to: :attendance
  belongs_to :attendance_to_change, class_name: 'Attendance', optional: true
  belongs_to :receiver, class_name: 'User'
  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 20 }
  validates :attendance_to_change_id, uniqueness: { allow_nil: true, if: -> { attendance_to_change_id.present? } }
  validates :attendance_to_change_id, presence: { if: -> { attendance.status == "modification_request" } }
  validate :both_attendance_id_must_belong_to_same_user, if: -> { attendance.status == 'modification_request' }
  validate :content_must_express_gratitude, if: -> { attendance.status == "finish" }


  private
    def both_attendance_id_must_belong_to_same_user
      return unless attendance_to_change
      if attendance&.user_id != attendance_to_change&.user_id
        errors.add(:attendance_to_change, "他のユーザーの出退勤の変更申請はできません")
      end
    end
      
    def content_must_express_gratitude
      unless content &.include?("ありがとう")
        errors.add(:content, "「ありがとう」という言葉を含めてください！")
      end
    end
end
