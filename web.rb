require 'sinatra'
require './app/model'
require './app/produkty'
require './app/string.rb'
require './app/parser.rb'
require 'bcrypt'

class Protected < Sinatra::Base
  set :sessions => true

  register do
    def auth (type)
      condition do
        redirect "/login" unless send("is_#{type}?")
      end
    end
  end

  helpers do
    def is_user?
      @user != nil
    end
  end

  before do
    @user = User.get(session[:user_id])
  end

  post "/login" do
    session[:user_id] = User.authenticate(params).id
  end

  get "/logout" do
    session[:user_id] = nil
  end

	get '/', :auth => :user do
		erb :index
	end

	get '/admin' do
		createModel
	end

	post '/ask' do
		return parseString(params[:query])
		return "Chyba coś poszło nie tak"
	end
end