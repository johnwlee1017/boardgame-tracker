class User < ApplicationRecord
  has_secure_password
  has_many :boardgames, foreign_key: "owner_id"
end
