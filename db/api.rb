require_relative '../config/environment.rb'

movies = Movie.all

movies.each do |movie|
  resp = RestClient.get "http://www.omdbapi.com/?i=#{movie.imdb}&apikey=#{Rails.application.secrets.omdb}"
  parse = JSON.parse(resp.body)
  if !Director.find_by(name: parse["Director"])
    director = Director.create(name: parse["Director"])
    director.movies << movie
  else
    director = Director.find_by(name: parse["Director"])
    if !director.movies.include?(movie)
      director.movies << movie
    end
  end
  parse["Actors"].split(", ").each do |actor|
    if !Actor.find_by(name: actor)
      new_actor = Actor.create(name: actor)
      new_actor.movies << movie
    else
      new_actor = Actor.find_by(name: actor)
      if !new_actor.movies.include?(movie)
        new_actor.movies << movie
      end
    end
    movie.update(plot: parse["Plot"], poster: parse["Poster"])
  end
end
