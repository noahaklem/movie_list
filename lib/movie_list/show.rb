class Show

  attr_accessor :locations

  # You need these: 
  # :id, :original_title, :overview, :vote_average, 
  # :location, :release_date
  
  @@all = []

  def initialize(tv_show_data)
    @locations = []
    attrs_from_data(tv_show_data)
    save
  end

  def attrs_from_data(tv_show_data)
    tv_show_data.each do |k, v|
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

  def self.new_from_api(tv_show_data)
    tv_show_data.each do |show_data|
      self.new(show_data)
    end
    CLI.all.last.show_tv_shows(self.all)
  end

  def self.request_shows
    API.new.get_data if self.all.empty?

    self.all
  end
  
  def self.find_show_in_array(number)
    show = self.all[number - 1]
  end

  def self.request_to_watch(show_id)
    API.new.where_to_watch_show(show_id) if self.all.last.locations.empty?
    self.all.last.locations
  end

  def self.find_by_id(show_id)
    self.all.find {|show| show.id == show_id}
  end
  
end