class CLI
  def call
    puts "Hi! Welcome to Movie List! \n"

    puts "\nI am going to help you find trending movies or shows and where to watch them."

    get_user_name
    select_movies_or_shows
    get_user_selection
  end

  def get_user_name
    puts "\nPlease enter your name to get started.\n"

    name = gets.strip
    puts "\nGreat, #{name}! Now, what would you like to see?\n"
  end

  def select_movies_or_shows
    @options = ["Trending Movies", "Trending TV Shows"]
    @options.each.with_index(1) do |option, index|
      puts "#{index}. #{option}"
    end
  end

  def convert_selection(selection)
    selection.to_i 
  end

  def valid_selection(number, data)
    number <= data.length && number > 0
  end

  def case_selector(number)
    case number  
    when 1 then show_movies #can use the then here
    when 2 then show_tv_shows #can use the then here too
    end
  end

  def get_user_selection
    puts "\nType: '1' for 'Trending Movies'\n or \nType: '2' for 'Trending Shows'\n"
    selection = gets.strip
    number = convert_selection(selection)
    valid_selection(number, @options) ? case_selector(number) : get_user_selection
  end

  def show_movies
    @movies = Movie.all
    @movies.each.with_index(1) do |movie, index| puts "
    #{index}. Movie Title: #{movie.original_title}
       Movie Overview: #{movie.overview}
       Movie Rating: #{movie.vote_average}\n
       WANT TO WATCH THIS MOVIE? 
       Type #{index} and find out where to watch this movie! "
    end
    watch_media_selection
  end

  def show_tv_shows
    # @tv_shows = TVShow.all
    puts "showing tv shows"
  end

  def watch_media_selection
    puts "\nWhich title number would you like to watch?"
    selection = gets.strip
    number = convert_selection(selection)
    @movie = valid_selection(number, @movies) ? Movie.find_movie_in_array(number) : watch_media_selection
    "\nNice, #{@movie.original_title}!"
    binding.pry
    request_to_watch(@movie.id)
  end

  def show_where_to_watch()

  end
end