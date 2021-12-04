require 'dotenv/load'
require 'httparty'
require 'open-uri'

require 'net/http'
require 'json'

require 'bundler/setup'

Bundler.require(:default, :development)

require_relative '../lib/movie_list/cli.rb'