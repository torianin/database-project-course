require 'sinatra'
require './app/checker'
require './app/model'
require './app/produkty'
require './app/uzytkownicy'
require './app/zapytania'
require './app/platnosci'
require './app/string'
require './app/parser'
require 'pusher'

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

set :sessions => true
set :session_secret, 'super secret'

helpers do
  def getSessionId
      session[:session_id]
  end

  def isAdmin?
    return (session[:role] == 'a')
  end

  def isClient?
    return (session[:role] == 'c')
  end

  def isDriver?
    return (session[:role] == 'd')
  end

  def isSeller?
    return (session[:role] == 's')
  end
end

get '/' do
  getSessionId
  session[:shoppingcart] = []
  session[:payment] = 0
	erb :index
end

post '/ask' do
  query = params[:query]
  query = query.downcase
  Pusher['sended-message'].trigger('sended-message', {:message => "#{query}", :userid =>"#{getSessionId}"})
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
  puts user.to_s
  puts params[:user]
  puts params[:password]
  if params[:user] == user[:login] and params[:password] == user[:password]
  	session[:login] = user[:login]
  	session[:role] = user[:role]
  	return "callback('OK');term.echo(\"Witaj #{user[:login]}\", aby uzyskać więcej informacji wpisz pomoc.);"
  else
  	return "callback()"
  end
end
