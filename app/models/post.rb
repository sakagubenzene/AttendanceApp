class Post < ApplicationRecord
  belongs_to :user
  has_one :attendance, dependent: :destroy
  has_one :message, dependent: :destroy
end
