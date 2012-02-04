require 'rubygems'
require 'sinatra'
require 'sass'

set :haml, format: :html5

get '/' do
  if params[:remote]
    haml :iphone, layout: false
  else
    haml :iphone
  end
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