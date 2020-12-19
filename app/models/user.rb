class User < ApplicationRecord
  has_secure_password
  has_many :conversations
  has_many :messages

  validates :username, presence: true,
                       uniqueness: true
  validates :password, presence: true
end
