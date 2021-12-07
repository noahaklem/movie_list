# frozen_string_literal: true

require_relative "lib/movie_list/version"

Gem::Specification.new do |spec|
  spec.name          = "movie_list"
  spec.version       = MovieList::VERSION
  spec.authors       = ["Noah A Klem"]
  spec.email         = ["noahaklem@gmail.com"]

  spec.summary       = "Return a list of trending movies or shows and where to watch them."
  spec.description   = "Welcome to Movie_List! This gem is designed to get trending movies and shows from an external source API then display the results to the user. As an added bonus, the user will be able to input a title number to get a list of where the movie or show is available to watch. Enjoy!"
  spec.homepage      = "https://github.com/noahaklem/movie_list"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/noahaklem/movie_list"
  spec.metadata["changelog_uri"] = "https://github.com/noahaklem/movie_list"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'dotenv'
  spec.add_dependency 'open-uri'
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "pry"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end