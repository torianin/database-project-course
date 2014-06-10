require 'sinatra'
require './app/model'
require './app/produkty'
require './app/uzytkownicy'
require './app/zapytania'
require './app/string'
require './app/parser'
require './app/utilities'

set :sessions => true
set :session_secret, 'super secret'

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
  user = getUserId(params[:user])
  if params[:user] == user[:login] and params[:password] == user[:password]
  	session[:login] = user[:login]
  	session[:role] = user[:role]
  	return "callback('OK');term.echo(\"Witaj #{user[:login]}\");"
  else
  	return "callback()"
  end
end
