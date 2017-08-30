# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

movies = {}


# CSV_FILE_PATH = File.join(File.dirname(__FILE__), "movies.csv")

CSV.foreach("db/movies.csv", :headers => true, :header_converters => :symbol, :converters => :all) do |row|
  movies
end

data = CSV.read("db/movies.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})

hashed_data = data.map { |d| d.to_hash }
Movie.bulk_insert do |movie|
  hashed_data.each do |row|
    movie.add(year: row[:year], title: row[:title], imdb: row[:imdb], binary: row[:binary], detail: row[:clean_test])
  end
end

jason = User.create(username: "jason", first_name: "Jason", last_name: "Tseng", password: "jason")

movie = Movie.first

rating = Rating.create(movie_id: movie.id, user_id: jason.id, binary: 'PASS', comments: "something")
