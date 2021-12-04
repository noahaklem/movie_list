class CLI
  def call
    puts "Hi! Welcome to Movie List!"
    puts "I am going to help you find trending movies or shows and where to watch them."
    puts "Please enter your name to get started."

    name = gets.strip
    puts "Great, #{name}! Now, what would you like to see?"
  end

  def select_movies_or_shows
    @selection = ["1. Trending Movies", "2. Trending Shows"]
  end

  
end