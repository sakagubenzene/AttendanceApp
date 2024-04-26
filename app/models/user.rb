class User < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :messages, through: :attendances
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy
  has_secure_password

  attr_accessor :remember_token
  validates :name, presence: true, length: { maximum: 50 }
  validates :employee_number, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end

    def ransackable_attributes(auth_object = nil)
      ["admin", "created_at", "employee_number", "id", "name", "password_digest", "remember_digest", "updated_at", "timestamp"]
    end

    def ransackable_associations(auth_object = nil)
      ["attendances", "messages", "received_messages"]
    end
  end

  # 永続的セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # セッションハイジャック防止のためにセッショントークンを返す
  # この記憶ダイジェストを再利用しているのは単に利便性のため
  def session_token
    remember_digest || remember
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

end
