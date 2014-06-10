require 'sinatra'
require './app/model'
require './app/produkty'
require './app/uzytkownicy'
require './app/zapytania'
require './app/string'
require './app/parser'
require 'bcrypt'

set :sessions => true

get '/' do
	erb :index
end

get '/admin' do
	createModel
end

post '/ask' do
  puts params[:query]
  addQuery(params[:query])
	return parseString(params[:query])
	return "Chyba coś poszło nie tak"
end

post '/login' do
  puts params[:user],params[:password]
  if params[:user] == "admin" and params[:password] == "21232f297a57a5a743894a0e4a801fc3"
  	return "callback('OK');term.echo(\"Zalogowano\");"
  else
  	return "callback()"
  end
end
