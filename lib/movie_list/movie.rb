class Movie

  attr_accessor :id, :original_title, :overview, :vote_average

  @@all = []

  def initialize(id, original_title, overview, vote_average)
    @id = id
    @original_title = original_title
    @overview = overview
    @vote_average = vote_average
    save
  end

  def self.new_from_api(movies)
    movies.each do |movie|
      # binding.pry
      id = movie['id']
      original_title = movie['original_title']
      overview = movie['overview']
      vote_average = movie['vote_average']
      Movie.new(id,original_title,overview,vote_average)
    end
  end
  

  def save
    @@all << self
  end

  def self.all
    API.get_movies if @@all.empty?
    @@all
  end

  def where_to_watch(movie_number)

  end
end