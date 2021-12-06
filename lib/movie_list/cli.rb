class CLI
  def call
    puts "Hi! Welcome to Movie List! \n"

    puts "\nI am going to help you find trending movies or shows and where to watch them."

    select_movies_or_shows
    get_user_selection
  end

  def select_movies_or_shows
    @options = ["Trending Movies", "Trending TV Shows"]
    @options.each.with_index(1) {|option, index| puts "#{index}. #{option}"}
  end

  def get_user_selection
    puts "Now, what would you like to see?
    \nType: '1' for 'Trending Movies'\n or \nType: '2' for 'Trending Shows'\n"
    number = convert_selection(gets.strip)
    valid_selection(number, @options) ? case_selector(number) : get_user_selection
  end

  def convert_selection(selection)
    selection.to_i 
  end

  def valid_selection(number, data)
    number <= data.length && number > 0
  end

  def case_selector(number)
    case number  
    when 1 then Movie.request_movies #can use the then here
    when 2 then show_tv_shows #can use the then here too
    end
  end

  def self.show_movies(all_movies)
    all_movies.each.with_index(1) do |movie, index| puts "
    #{index}. Movie Title: #{movie.original_title} -- Release Date: #{movie.release_date}
       Movie Overview: #{movie.overview}
       Movie Rating: #{movie.vote_average}\n
       WANT TO WATCH THIS MOVIE? 
       Type #{index} and find out where to watch this movie! "
    end
    get_media_selection
  end

  def show_tv_shows
    # @tv_shows = TVShow.all
    puts "showing tv shows"
  end

  def get_media_selection
    puts "\nWhich title number would you like to watch?"
    number = convert_selection(gets.strip)
    @movie = valid_selection(number, @movies) ? Movie.find_movie_in_array(number) : watch_media_selection
    binding.pry
    puts "\nNice choice! Here's where to watch #{@movie.original_title}!"

    Movie.request_to_watch(@movie.id)
  end

  def self.show_where_to_watch
    @locations = Location.all
    @locations.each.with_index(1) do |location, index| 
      puts " #{index}. #{location.provider_name}"
    end
  end

  def self.all_done
   puts "\nAll done here?\n
   Enter: 'y' or 'n'"
   exit
   selection = gets.strip

  end

end