require 'sinatra'
require './app/checker'
require './app/model'
require './app/produkty'
require './app/uzytkownicy'
require './app/zapytania'
require './app/string'
require './app/parser'

set :sessions => true
set :session_secret, 'super secret'

def getSessionName
  session[:name]
end

get '/' do
  getSessionId
  session[:shoppingcart] = []
	erb :index
end

get '/admin' do
	createModel
end

post '/ask' do
  query = params[:query]
  query = query.downcase
  addQuery(query)
  d = Dictionary.instance
  checkedValue = d.checkWords(query) 
  if checkedValue != true
    return checkedValue
  end
	return parseString(query)
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
