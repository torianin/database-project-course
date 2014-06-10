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
  user = getUserId(params[:user])
  puts user
  if params[:user] == "admin" and params[:password] == "669a84def65ee15142c5abb9ee29e2de"
  	return "callback('OK');term.echo(\"Zalogowano\");"
  else
  	return "callback()"
  end
end
