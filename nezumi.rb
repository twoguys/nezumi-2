require 'rubygems'
require 'rack/cache'
require 'sinatra'
require 'haml'
require 'sass'
require 'twitter'
require 'dalli'

# Cache it...cache it good
$cache = Dalli::Client.new
set :enable_cache, true
set :cache, $cache
use ::Rack::Cache, metastore: $cache, entitystore: 'file:tmp/cache/entity'

set :haml, format: :html5

before do
  # response["Cache-Control"] = "max-age=300, public"
  set :static_cache_control, [:public, max_age: 300]
  cache_control :public, max_age: 300
end

get '/' do
  begin
    @twitter_text = Twitter.user_timeline("nezumiapp").first.text
  rescue
    # rate exceeded...by your face!
  end
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