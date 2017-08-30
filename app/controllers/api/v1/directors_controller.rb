class Api::V1::DirectorsController < ApplicationController

  def show
    director = Director.find(params[:id])
    movies = director.movies.map { |movie| {movie: movie, actors: movie.actors} }
    render json: {director: director, movies: movies}
  end

  def index
    directors = Director.all
    render json: directors
  end

end
