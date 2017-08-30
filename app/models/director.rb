class Director < ApplicationRecord
  has_many :movies
  has_many :actors, through: :movies
  has_many :ratings, through: :movies
end
