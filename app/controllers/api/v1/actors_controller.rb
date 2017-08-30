class Api::V1::ActorsController < ApplicationController

  def show
    actor = Actor.find(params[:id])
    movies = actor.movies.map { |movie| {movie: movie, director: movie.director} }
    render json: {actor: actor, movies: movies}
  end

  def index
    actors = Actor.all
    render jason: actors
  end

end
