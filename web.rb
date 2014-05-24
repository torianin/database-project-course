require 'sinatra'
require './app/model'

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