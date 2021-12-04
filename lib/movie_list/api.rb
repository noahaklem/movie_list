class API
  
  def trending_movies
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
      # binding.pry
      results = JSON.parse(response.body)
      Movies.new_from_api(results['results'])
  end

  def watch_movies
    url = "https://api.themoviedb.org/3/movie/#{movie_id_from_trending_movies_interaction}/watch/providers?api_key=#{ENV['SECRET_KEY']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    # binding.pry
    results = JSON.parse(response.body)
    # Movies.new_from_api(results['results']['US'])
  end
end