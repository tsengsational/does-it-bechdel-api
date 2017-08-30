class User < ApplicationRecord
  has_many :ratings
  has_many :movies, through: :ratings
  has_secure_password
end
