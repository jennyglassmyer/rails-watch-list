require 'open-uri'


link = "http://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(link).read
movies = JSON.parse(movies_serialized)

puts "Clearing database..."
Movie.destroy_all

puts "Creating new movies..."
movies["results"].each do |movie|
  new_movie = Movie.create!(
    title: movie["title"], 
    overview: movie["overview"], 
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}", 
    rating: movie["vote_average"])
  puts "Created #{new_movie.title}"
end 

puts "Finished!"