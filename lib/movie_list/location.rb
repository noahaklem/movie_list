class Location
  # You need these
  # :provider_id, :provider_name

  @@all = []

  def initialize(where_to_watch_data)
    attrs_from_data(where_to_watch_data)
    save
  end

  def save
    self.class.all << self
  end

  def attrs_from_data(where_to_watch_data)
    where_to_watch_data.each do |k, v|
      self.class.attr_accessor(k)
      send("#{k}=", v)
    end
  end

  def self.all
    # API.where_to_watch_media if self.all.empty?
    @@all
  end

  def self.where_to_watch(watch_results, data)
    data.class == Show ? media = Show.find_by_id(data.id) : media = Movie.find_by_id(data.id)
    watch_results.each do |location|
      self.new(location)
      media.locations << location
    end
    CLI.all.last.show_where_to_watch(self.all)
  end

  # def self.where_to_watch_movie(watch_results, id)
  #   @movie = Movie.find_by_id(id)
  #   watch_results.each do |location|
  #     self.new(location)
  #     @movie.locations << location
  #   end
  #   CLI.all.last.show_where_to_watch(self.all)
  # end

  # def self.where_to_watch_show(watch_results, id)
  #   @show = Show.find_by_id(id)
  #   watch_results.each do |location|
  #     self.new(location)
  #     @show.locations << self
  #   end
  #   CLI.all.last.show_where_to_watch(self.all)
  # end
end