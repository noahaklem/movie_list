class Movie

  attr_accessor :id, :original_title, :overview, :vote_average

  @@all = []

  def initialize(id, original_title, overview, vote_average, location = [])
    @id = id
    @original_title = original_title
    @overview = overview
    @vote_average = vote_average
    @location = location
    save
  end

  def self.new_from_api(movies_data)
    movies_data.each do |movie|
      # binding.pry
      id = movie['id']
      original_title = movie['original_title']
      overview = movie['overview']
      vote_average = movie['vote_average']
      location = []
      Movie.new(id,original_title,overview,vote_average, location)
    end
  end
  
  def save
    @@all << self
  end

  def self.all
    API.get_movies if @@all.empty?
    @@all
  end

  def self.find_movie_in_array(number)
    @movie = self.all[number - 1]
  end

  def self.request_to_watch(id)
    API.where_to_watch_media(id)
  end

  def self.find_by_id(movie_id)
    self.all.find {|movie| movie.id == movie_id}
  end

end