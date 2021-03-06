require 'rubygems'
require 'rack/cache'
require 'sinatra'
require 'haml'
require 'sass'
require 'dalli'

# Cache it...cache it good
#$cache = Dalli::Client.new
#set :enable_cache, true
#set :cache, $cache
#use ::Rack::Cache, metastore: $cache, entitystore: 'file:tmp/cache/entity'

set :haml, format: :html5

before do
  # response["Cache-Control"] = "max-age=300, public"
  set :static_cache_control, [:public, max_age: 300]
  cache_control :public, max_age: 300
end

get '/' do
  haml :iphone
end

get '/iphone' do
  haml :iphone, layout: false
end

get '/ipad' do
  if params[:remote]
    haml :ipad, layout: false
  else
    haml :ipad
  end
end

get '/android' do
  if params[:remote]
    haml :android, layout: false
  else
    haml :android
  end
end

get '/addons' do
  if params[:remote]
    haml :addons, layout: false
  else
    haml :addons
  end
end

get '/appstore' do
  redirect 'http://itunes.apple.com/us/app/nezumi/id346715875?mt=8'
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
