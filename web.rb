require 'sinatra'
require './app/model'
require './app/string.rb'
require './app/parser.rb'
require 'bcrypt'

class Protected < Sinatra::Base
	enable :sessions

	helpers do

	end

	use Rack::Auth::Basic, "Protected Area" do |username, password|
	  username == 'admin' && password == 'test'
		
	end

	get '/' do
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