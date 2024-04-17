class Post < ApplicationRecord
  belongs_to :user
  has_one :attendance, dependent: :destroy
  has_one :message, dependent: :destroy
  accepts_nested_attributes_for :attendance
  accepts_nested_attributes_for :message
end
