class User < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy
  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  validates :employee_number, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

end
