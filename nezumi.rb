require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'twitter'
require 'dalli'
require 'rack-cache'

$cache = Dalli::Client.new
set :cache, $cache
use ::Rack::Cache, :metastore => $cache, :entitystore => 'file:tmp/cache/entity'

set :haml, format: :html5

get '/' do
  response["Cache-Control"] = "max-age=300, public"
  haml :iphone
end

get '/iphone' do
  haml :iphone, layout: false
end

get '/ipad' do
  haml :ipad, layout: false
end

get '/android' do
  haml :android, layout: false
end

get '/addons' do
  haml :addons, layout: false
end

# STYLESHEETS

get '/stylesheets/reset.css' do
  content_type 'text/css', charset: 'utf-8'
  sass :reset
end

get '/stylesheets/styles.css' do
  content_type 'text/css', charset: 'utf-8'
  sass :styles
end