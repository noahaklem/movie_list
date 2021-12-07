class CLI
  attr_accessor :movies, :shows
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
    get_user_selection
  end

  def get_user_selection
    puts "\nWhat would you like to see?
    \nType: '1' for 'Trending Movies'\n or \nType: '2' for 'Trending TV Shows'\n"
    number = convert_selection(gets.strip)
    valid_selection(number, ["Trending Movies", "Trending TV Shows"]) ? case_selector(number) : get_user_selection
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

  def show(all_data)
    all_data.each.with_index(1) do |data, index| 
      puts "
      #{index}. Title: #{data.class == Show ? data.name : data.title} 
        Overview: #{data.overview}
        Rating: #{data.vote_average}\n
        WANT TO WATCH THIS TITLE?
        Type #{index} and find out where to watch!"
    end
    get_selection(all_data)
  end

  def get_selection(all_data)
    puts "\nWhich title number would you like to watch?"
    number = convert_selection(gets.strip)
    valid_selection(number, all_data) ? data = all_data.first.class.find_in_array(number) : get_selection
    puts "\nNice choice! Here's where to watch #{data.class == Show ? data.name : data.title}"
    data.class.request_to_watch(data)
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
    case @exit_program
      when 'y' then exit
      when 'n' then self.class.all.last.call
      else all_done
    end
  end
end