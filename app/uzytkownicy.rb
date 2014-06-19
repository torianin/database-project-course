require './app/model'
require 'pusher'
require "digest/md5"

Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

def rola(rola)
  role = {
    "c" => "client", 
    "a" => "admin", 
    "s" => "sprzedawca", 
    "d" => "kierowca"
  }
  return role[rola]
end

def printUsers
	p = PostgresConnector.instance
  @rows = []
  p.getConnector.exec( "SELECT * FROM users" ) do |result|
    result.each do |row|
      @rows << [row['id_user'].to_s,row['mail'],row['login'],rola(row['role']),row['date']]
    end
  end
  table = Terminal::Table.new :headings => ['Id','Mail','Login','Rola','Data dołączenia'], :rows => @rows
  table.to_s
end

def addUser(mail, login, password, role)
  p = PostgresConnector.instance
  p.getConnector.exec_prepared("insert_users", [mail, login, Digest::MD5.hexdigest(password), role])
end

def getUserId(login)
	p = PostgresConnector.instance
	info = Hash.new
  p.getConnector.exec( "SELECT * FROM users WHERE login ='#{login}' " ) do |result|
    result.each do |row|
    	info = { :login => row['login'], :password => row['password'], :role => row['role'] }
    end
  end
	info
end

def getUser()
     Pusher['test_channel'].trigger("#{session[:session_id]}", {
        message: '#alert("Dziala");'
      })
end