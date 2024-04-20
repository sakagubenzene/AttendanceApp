class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :post,optional: true
  default_scope -> { order(created_at: :desc) }

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :content, presence: true, length: { minimum: 1, maximum: 100 }
  validate :content_must_include_specific_word

  private
    def content_must_include_specific_word
      unless content &.include?("ありがとう")
        errors.add(:content, "「ありがとう」という言葉を含めてください！")
      end
    end
end
