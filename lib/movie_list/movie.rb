class Movie

  attr_accessor :locations

  # You need these: 
  # :id, :original_title, :overview, :vote_average, 
  # :location, :release_date
  
  @@all = []

  def initialize(movie_data)
    @locations = []
    attrs_from_data(movie_data)
    save
  end

  def attrs_from_data(movie_data)
    movie_data.each do |k, v|
      self.class.attr_accessor(k)
      send("#{k}=", v)
    end
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.new_from_api(movies_data)
    movies_data.each do |movie_data|
      self.new(movie_data)
    end
    CLI.all.last.show_movies(self.all)
  end

  def self.request_movies
    API.new.get_movies if self.all.empty? # might need logic
  end
  
  def self.find_movie_in_array(number)
    movie = self.all[number - 1]
  end

  def self.request_to_watch(id)
    API.new.where_to_watch_movie(id)
  end

  def self.find_by_id(movie_id)
    self.all.find {|movie| movie.id == movie_id}
  end

end