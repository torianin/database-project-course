require 'sinatra'
require './app/model'
require './app/produkty'
require './app/string.rb'
require './app/parser.rb'
require 'bcrypt'

class Protected < Sinatra::Base
  set :sessions => true

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