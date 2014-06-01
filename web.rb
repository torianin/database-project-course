require 'sinatra'
require './app/model'
require './app/string.rb'

class Protected < Sinatra::Base

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
		if params[:query] == 'pomoc'
			return $pomoc
		else
			return "Chyba coś poszło nie tak"
		end
	end
end