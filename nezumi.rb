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

before do
  response["Cache-Control"] = "max-age=300, public"
end

get '/' do
  begin
    @twitter_text = Twitter.user_timeline("nezumiapp").first.text
  rescue
    # rate exceeded
  end
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

# STYLESHEETS

get '/stylesheets/reset.css' do
  content_type 'text/css', charset: 'utf-8'
  sass :reset
end

get '/stylesheets/styles.css' do
  content_type 'text/css', charset: 'utf-8'
  sass :styles
end