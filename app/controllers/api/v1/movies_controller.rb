class Api::V1::MoviesController < ApplicationController

  def index
    @movies = Movie.all
    render json: @movies
  end

  def create
    resp = RestClient.get "http://www.omdbapi.com/?t=#{params[:movie][:title]}&apikey=#{Rails.application.secrets.omdb}"
    parse = JSON.parse(resp.body)
    if parse["Error"] == "Movie not found!"
      render json: {error: "Movie not found!"}
    else
      if Movie.find_by(title: params[:movie][:title])
        @movie = Movie.find_by(title: params[:movie][:title])
        @movie.update(binary: params[:movie][:binary], detail: params[:movie][:detail], year: parse["Year"], imdb: parse["imdbID"])
        if !Director.find_by(name: parse["Director"])
          @director = Director.create(name: parse["Director"])
          @director.movies << @movie
        else
          @director = Director.find_by(name: parse["Director"])
          if !@director.movies.include?(@movie)
            @director.movies << @movie
          end
        end
        parse["Actors"].split(", ").each do |actor|
          if !Actor.find_by(name: actor)
            @actor = Actor.create(name: actor)
            @actor.movies << @movie
          else
            @actor = Actor.find_by(name: actor)
            if !@actor.movies.include?(@movie)
              @actor.movies << @movie
            end
          end
        end
      else
        @movie = Movie.create(year: parse["Year"], title: parse["Title"], imdb: parse["imdbID"], binary: params[:movie][:binary], detail: params[:movie][:detail])
        if !Director.find_by(name: parse["Director"])
          @director = Director.create(name: parse["Director"])
          @director.movies << @movie
        else
          @director = Director.find_by(name: parse["Director"])
          if !@director.movies.include?(@movie)
            @director.movies << @movie
          end
        end
        parse["Actors"].split(", ").each do |actor|
          if !Actor.find_by(name: actor)
            @actor = Actor.create(name: actor)
            @actor.movies << @movie
          else
            @actor = Actor.find_by(name: actor)
            if !@actor.movies.include?(@movie)
              @actor.movies << @movie
            end
          end
        end
      end
    end
    render json: {
      movie: @movie,
      actors: @movie.actors,
      director: @movie.director
    }
  end

  def show
    @movie = Movie.find(params[:id])
    render json: {
      movie: @movie,
      actors: @movie.actors,
      director:@movie.director
    }
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(params[:movie])
    render json: @movie
  end

  def search
    if Movie.find_by(title: params[:movie][:title])
      @movie = Movie.find_by(title:
      params[:movie][:title])
      render json: {movie: @movie, actors: @movie.actors, director: @movie.director}
    else
      render json: {error: "Movie not found."}
    end
  end

end
