class MovieList::API

  @@all = []

  def initialize
    @movies_data = []
    @shows_data = []
    @locations_data = []
    save
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def get_data(data_class)
    url = "https://api.themoviedb.org/3/trending/all/day?api_key=#{ENV['SECRET_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    results = JSON.parse(response.body)['results']
    organize_data(results)
    data_class == MovieList::Show ? data_class.new_from_api(@shows_data) : data_class.new_from_api(@movies_data)
  end
  
  def organize_data(data)
    data.each do |media|
      media['media_type'] == 'movie' ? @movies_data << media : @shows_data << media
    end
  end
  
  def where_to_watch(data)
    !data ? data.class.request_to_watch(data) : make_watch_request(data)
  end
  
  def make_watch_request(data)
    data.class == MovieList::Show ? url = "https://api.themoviedb.org/3/tv/#{data.id}/watch/providers?api_key=#{ENV['SECRET_KEY']}" : url = "https://api.themoviedb.org/3/movie/#{data.id}/watch/providers?api_key=#{ENV['SECRET_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    results = JSON.parse(response.body)['results']['US']
    !results || results == {} ? default_results(results) : where_to_watch_data(data, results) 
    MovieList::Location.new_from_api(@locations_data, data)
  end

  def where_to_watch_data(data, results)
    data.class == MovieList::Show ? show_watch_data(results) : movie_watch_data(results)
  end
  
  def movie_watch_data(results)
    organize_where_to_watch_data(results['rent']) if results['rent']
    organize_where_to_watch_data(results['flatrate']) if results['flatrate']
    organize_where_to_watch_data(results['buy']) if results['buy']
  end
  
  def show_watch_data(results)
    organize_where_to_watch_data(results['ads']) if results['ads']
    organize_where_to_watch_data(results['flatrate']) if results['flatrate']
    organize_where_to_watch_data(results['buy']) if results['buy']
  end
  
  
  def default_results(results)
    values = []
    results = {}
    results["display_priority"] = "1"
    results["logo_path"] = nil
    results["provider_id"] = "1"
    results["provider_name"] = "This title may only be in theaters only."
    values << results
    organize_where_to_watch_data(values)
  end
  
  
  def organize_where_to_watch_data(data)
    data.each do |location| 
      @locations_data << location if !location.empty? 
    end
  end
end
