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

  def get_user_selection
    puts "\nType: 1 for 'Trending Movies'\n or \nType: 2 for 'Trending Shows'\n"
    selection = gets.strip
    number = convert_selection(selection)
    if valid_selection(number, @options) 
      case number  
      when 1
        puts "show_movies"
      when 2
        puts "show_tv_shows"
      end
    else
      puts "\nTry again! Remember use numbers to make a selection.\n"
      get_user_selection
    end
  end
  
end