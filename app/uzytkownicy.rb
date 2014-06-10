require './app/model'

def printUsers
	p = PostgresConnector.instance
	puts p
	value = ""
  p.getConnector.exec( "SELECT * FROM users" ) do |result|
    result.each do |row|
      value = value +"Użytkownicy : " + category(row['id_user']) + ". " + effect(row['login']) + ", " + row['role'] + "\n" + row['data'] + "\n"
    end
  end
	value
end

def addUser(mail, login, password, role)
  p = PostgresConnector.instance
  p.getConnector.exec_prepared("insert_users", [mail, login, password, role, data,first_time])
end
