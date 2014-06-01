require 'sinatra'
require './app/model'

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
		if params[:query] == 'login = torianin'
			return "Witaj w mega nielegalnym sklepie"
		else
			return "Wogóle nie mam pojęcia kim jesteś"
		end
	end
end