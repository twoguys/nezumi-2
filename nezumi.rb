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
    @twitter_text = settings.cache.get("tweet")
    unless @twitter_text
      tweet = Twitter.user_timeline("nezumiapp").first.text
      @twitter_text = tweet.size > 94 ? tweet.slice(0..93) << "..." : tweet
      settings.cache.set("tweet", @twitter_text)
    end
  rescue Twitter::Error => e
    # rate exceeded...by your face!
    @twitter_text = e.message
  rescue Dalli::RingError
    # no memcache
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