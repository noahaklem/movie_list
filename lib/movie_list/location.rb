class Location
  attr_accessor :provider_id, :provider_name

  @@all = []

  def initialize(provider_id, provider_name)
    @provider_id = provider_id
    @provider_name = provider_name
    save
  end

  def save
    @@all << self
  end

  def self.all
    API.where_to_watch_media if @@all.empty?
    @@all
  end

  def self.where_to_watch(watch_results, id)
    @movie = Movie.find_by_id(id)
    watch_results.each do |location|
      provider_id = location['provider_id']
      provider_name = location['provider_name']
      Location.new(provider_id, provider_name)
    end
    CLI.show_where_to_watch
  end
end