require './app/model'

def printUsers
	p = PostgresConnector.instance
	puts p
	value = ""
  p.getConnector.exec( "SELECT * FROM users" ) do |result|
    result.each do |row|
      value = value + row['id_user'].to_s + " : " + row['mail'].to_s + ", " + row['login'].to_s + ", " + row['role'].to_s + ", " + row['data'].to_s + "\n"
    end
  end
	value
end

def addUser(mail, login, password, role)
  p = PostgresConnector.instance
  p.getConnector.exec_prepared("insert_users", [mail, login, password, role])
end
