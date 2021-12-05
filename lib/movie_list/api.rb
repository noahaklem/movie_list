class API
  
  def self.get_movies
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

    movies = []
    tv_shows = []
    results['results'].each do |media|
      media['media_type'] == 'movie' ? movies << media : tv_shows << media
    end

    Movie.new_from_api(movies)

  end

  def where_to_media(id)
    url = "https://api.themoviedb.org/3/movie/#{id}/watch/providers?api_key=#{ENV['SECRET_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    # binding.pry
    results = JSON.parse(response.body)
    binding.pry
    Movie.where_to_watch(results['results']['US'])
  end
end