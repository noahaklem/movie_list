class Movie

  attr_accessor :id, :original_title, :overview, :vote_average

  @@all = []

  def initialize(title)
    @original_title = title
    save
  end

  

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end
end