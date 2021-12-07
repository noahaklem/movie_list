# frozen_string_literal: true

require 'dotenv/load'
require 'httparty'
require 'open-uri'
require 'byebug'

require 'net/http'
require 'json'

require 'bundler/setup'

Bundler.require(:default, :development)

require_relative '../lib/movie_list/cli.rb'
require_relative '../lib/movie_list/movie.rb'
require_relative '../lib/movie_list/api.rb'
require_relative '../lib/movie_list/location.rb'
require_relative '../lib/movie_list/show.rb'



require_relative "movie_list/version"

module MovieList
  class Error < StandardError; end
  # Your code goes here...
end