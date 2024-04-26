class Attendance < ApplicationRecord
  has_one :message, class_name: 'Message', dependent: :destroy
  accepts_nested_attributes_for :message
  belongs_to :user
  has_one :which_attendance, class_name: 'Message', foreign_key: 'attendance_to_change_id', dependent: :nullify

  validates :timestamp, presence: true
  validates :status, inclusion: { in: ['begin', 'finish', 'modification_request', 'settled', 'unsettled'],
                                  message: "%{value} is not a valid status" },
                      presence: true
  validate :valid_status_transition, if: -> { status == "begin" || status == "finish" }
  validate :time_check, if: -> { status == "modification_request" }

  
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
    when "unsettled"
      "修正却下済み"
    else
      status
    end
  end
  
  def display_selection
    status_txt =
    "#{timestamp.strftime('%Y-%m-%d %H:%M:%S')} - #{status_to_japanese}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "status", "timestamp", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["message", "user", "which_attendance"]
  end
  
  private
    def valid_status_transition
      last_significant_record = user.attendances
                                    .where('timestamp < ?', timestamp)
                                    .where.not(status: ['modification_request', 'settled', 'unsettled'])
                                    .order(timestamp: :desc)
                                    .first
    
      if last_significant_record.present?
        if status == 'begin' && last_significant_record.status != 'finish'
          errors.add(:base, '出勤を連続で記録することはできません。')
        elsif status == 'finish' && last_significant_record.status != 'begin'
          errors.add(:base, '退勤を連続で記録することはできません。')
        end
      end
    end

    def time_check
      errors.add(:base, "現在の日時より遅い日時は選択できません。") unless timestamp < Time.now
    end
end
