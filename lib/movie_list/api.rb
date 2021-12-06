class API

  @@all = []

  def initialize
    @movies_data = []
    @tv_shows_data = []
    @where_to_watch = []
    save
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end
  
  def get_movies
    # response #1
    # url = ('https://api.themoviedb.org/3/trending/all/day?') 
    # uri = URI.parse(url)
    # headers = {
    #   "Authorization" => "Bearer #{ENV['READ_SECRET_KEY']}" 
    # }
    # response = HTTParty.get(uri, headers: headers)
    # binding.pry
    # response['results']

    # response #2
    url = "https://api.themoviedb.org/3/trending/all/day?api_key=#{ENV['SECRET_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    results = JSON.parse(response.body)

    organize_data(results['results'])

    Movie.new_from_api(@movies_data)
  end

  def get_tv_shows
    url = "https://api.themoviedb.org/3/trending/all/day?api_key=#{ENV['SECRET_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    results = JSON.parse(response.body)

    organize_data(results['results'])

    Show.new_from_api(@tv_shows_data)
  end

  def organize_data(data)
    data.each do |media|
      media['media_type'] == 'movie' ? @movies_data << media : @tv_shows_data << media
    end
  end

  def organize_where_to_watch_data(data)
    data.each do |location| 
      @where_to_watch << location if !location.empty? 
    end
  end

  def where_to_watch_movie(id=nil)
    if id === nil
      puts "Houston, we have a problem"
    else
      make_movie_watch_request(id)
      Location.where_to_watch_movie(@where_to_watch, id)
    end
  end

  def make_movie_watch_request(id)
    url = "https://api.themoviedb.org/3/movie/#{id}/watch/providers?api_key=#{ENV['SECRET_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    results = JSON.parse(response.body)
   
    if results['results'] == {} 
      default_movie_results(results['results'])
    else
      organize_where_to_watch_data(results['results']['US']['flatrate']) if results['results']['US']['flatrate']
      organize_where_to_watch_data(results['results']['US']['buy']) if results['results']['US']['buy']
      organize_where_to_watch_data(results['results']['US']['rent']) if results['results']['US']['rent'] 
    end
  end

  def default_movie_results(results)
    values = []
    results = {}
    results["display_priority"] = "1"
    results["logo_path"] = nil
    results["provider_id"] = "1"
    results["provider_name"] = "This title may still be in theaters only"
    values << results
    organize_where_to_watch_data(values)
  end

  def where_to_watch_show(id=nil)
    if id === nil
      puts "Houston, we have a problem"
    else
      make_show_watch_request(id)
      Location.where_to_watch_show(@where_to_watch, id)
    end
  end

  def make_show_watch_request(show_id)
    url = "https://api.themoviedb.org/3/tv/#{show_id}/watch/providers?api_key=#{ENV['SECRET_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    results = JSON.parse(response.body)
    if results['results'] == {}  
      default_show_results(results['results']) 
    else
      organize_where_to_watch_data(results['results']['US']['ads']) if results['results']['US']['ads']
      organize_where_to_watch_data(results['results']['US']['flatrate']) if results['results']['US']['flatrate']
      organize_where_to_watch_data(results['results']['US']['buy']) if results['results']['US']['buy']
    end
  end

  def default_show_results(results)
    values = []
    results = {}
    results["display_priority"] = "1"
    results["logo_path"] = nil
    results["provider_id"] = "1"
    results["provider_name"] = "This title may still be in theaters only."
    values << results
    organize_where_to_watch_data(values)
  end
end