class User < ApplicationRecord
  SHORT_NAME_MIN = 4
  SHORT_NAME_MAX = 15
  DISPLAY_NAME_MAX = 50
  EMAIL_MAX = 255
  PASSWORD_MIN = 6
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :short_name, presence: true, length: { in: SHORT_NAME_MIN..SHORT_NAME_MAX }
  validates :display_name, presence: true, length: { maximum: DISPLAY_NAME_MAX }
  validates :email, presence: true, length: { maximum: EMAIL_MAX }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
