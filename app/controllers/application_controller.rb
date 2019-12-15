require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "crazyfun"
  end

  get "/" do
    erb :welcome
  end

  
    # get '/index/' do
    #   "Hello World"
    # end


end
