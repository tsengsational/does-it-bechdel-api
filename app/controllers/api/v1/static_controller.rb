class Api::V1::StaticController < ApplicationController

  def search
    movies = Movie.all.map { |movie| {value: movie.title, id: movie.id, category: "movie"} }
    actors = Actor.all.map { |actor| {value: actor.name, id: actor.id, category: "actor" } }
    directors = Director.all.map { |director| {value: director.name, id: director.id, category: "director"} }
    suggestions = movies.concat(actors).concat(directors)
    render json: suggestions
  end

end
