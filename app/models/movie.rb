class Movie < ApplicationRecord
  belongs_to :director
  has_many :actor_movies
  has_many :actors, through: :actor_movies
  has_many :ratings
  has_many :users, through: :ratings
end
