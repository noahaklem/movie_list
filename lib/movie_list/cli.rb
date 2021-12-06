class CLI

  @@all = []

  def initialize
    save
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def call
    puts "Hi! Welcome to Movie List! \n"

    puts "\nI am going to help you find trending movies or shows and where to watch them."
    while @exit_program == 'n'
      select_movies_or_shows
      get_user_selection
    end
  end

  def select_movies_or_shows
    @options = ["Trending Movies", "Trending TV Shows"]
    @options.each.with_index(1) {|option, index| puts "#{index}. #{option}"}
  end

  def get_user_selection
    puts "\nNow, what would you like to see?
    \nType: '1' for '#{@options[0]}'\n or \nType: '2' for '#{@options[1]}'\n"
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
    when 2 then Show.request_shows #can use the then here too
    end
  end

  def show_movies(all_movies)
    all_movies.each.with_index(1) do |movie, index| puts "
    #{index}. Movie Title: #{movie.original_title} -- Release Date: #{movie.release_date}
       Overview: #{movie.overview}
       Rating: #{movie.vote_average}\n
       WANT TO WATCH THIS MOVIE? 
       Type #{index} and find out where to watch this movie! "
    end
    get_movie_selection(all_movies)
  end

  def get_movie_selection(all_movies)
    puts "\nWhich title number would you like to watch?"
    number = convert_selection(gets.strip)
    @movie = valid_selection(number, all_movies) ? Movie.find_movie_in_array(number) : get_movie_selection
    puts "\nNice choice! Here's where to watch #{@movie.original_title}!"
    
    Movie.request_to_watch(@movie.id)
  end

  def show_tv_shows(all_tv_shows)
    all_tv_shows.each.with_index(1) do |show, index| puts "
      #{index}. Show Title: #{show.original_name} -- Release Date: #{show.first_air_date}
         Overview: #{show.overview}
         Rating: #{show.vote_average}\n
         WANT TO WATCH THIS MOVIE? 
         Type #{index} and find out where to watch this movie! "
      end
      get_tv_selection(all_tv_shows)
  end

  def get_tv_selection(all_tv_shows)
    puts "\nWhich title number would you like to watch?"
    number = convert_selection(gets.strip)
    @show = valid_selection(number, all_tv_shows) ? Show.find_show_in_array(number) : get_tv_selection
    puts "\nNice choice! Here's where to watch #{@show.original_name}!"
    
    Show.request_to_watch(@show.id)
  end

  def show_where_to_watch(locations)
    locations.each.with_index(1) do |location, index|
      puts " #{index}. #{location.provider_name}"
    end
    all_done
  end

  def all_done
   puts "\nAll done here?\n
   Enter: 'y' or 'n'"
    @exit_program = gets.strip
    case exit_program
      when 'y' then exit
      when 'n' then @exit_program = 'n'
    end
  end

end