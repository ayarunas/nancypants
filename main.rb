require 'sinatra'
require 'slim'
require 'sass'
require './song'
require 'sinatra/reloader' if development?

configure do
  enable :sessions
  set :username, 'nancy'
  set :password, 'sinatra'
end

get '/styles.css' do
  scss :styles
end

get '/' do
  slim :home
end

get '/about' do
  @title = "About this site"
  slim :about
end

get '/contact' do
  @title = "Contact"
  slim :contact
end

get '/login' do
  slim :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    slim :login
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end

get '/environment' do
  if settings.development?
    "development"
  elsif settings.production?
    "production"
  elsif settings.test?
    "test"
  else
    "Not sure what environment this is running in."
  end
end

not_found do
  @title = "404"
  slim :not_found
end