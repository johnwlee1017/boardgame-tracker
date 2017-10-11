class User < ApplicationRecord
  has_secure_password
  has_many :boardgames, foreign_key: "owner_id"
  validates :password, :length => { :minimum => 4 }, on: :create
  validates :username, uniqueness: true, presence: true
end
