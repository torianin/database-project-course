require './app/model'

def printUsers
	p = PostgresConnector.instance
	value = ""
  p.getConnector.exec( "SELECT * FROM users" ) do |result|
    result.each do |row|
      value = value + row['id_user'].to_s + " : " + row['mail'] + ", " + row['login'] + ", " + row['role'] + ", " + row['date'] + "\n"
    end
  end
	value
end

def addUser(mail, login, password, role)
  p = PostgresConnector.instance
  p.getConnector.exec_prepared("insert_users", [mail, login, password, role])
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