class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_username

  validates :username, presence: true, uniqueness: true, format: /[a-zA-Z0-9_-]/
  validates :password, presence: true, length: { minimum: 6 }

  private

  def downcase_username
    self.username = username.downcase
  end
end
