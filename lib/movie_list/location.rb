class MovieList::Location
  # You need these
  # :provider_id, :provider_name

  @@all = []

  def initialize(locations_data)
    attrs_from_data(locations_data)
    save
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def attrs_from_data(locations_data)
    locations_data.each do |k, v|
      self.class.attr_accessor(k)
      send("#{k}=", v)
    end
  end

  def self.new_from_api(locations_data, data)
    reset
    data.class == MovieList::Show ? media = MovieList::Show.find_by_id(data.id) : media = MovieList::Movie.find_by_id(data.id)
    locations_data.each do |location|
      self.new(location)
    end
    media.locations << self.all
    MovieList::CLI.all.last.show_where_to_watch(self.all)
  end

  def self.reset
    all.clear
  end
end