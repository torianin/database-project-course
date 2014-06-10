require './app/model'

def printProducts
	p = PostgresConnector.instance
	puts p
	value = ""
  p.getConnector.exec( "SELECT * FROM users" ) do |result|
    result.each do |row|
      value = value +"Użytkownicy : " + category(row['category']) + "\nEfekt : " + effect(row['effects']) + "\nOpis : " + row['discription'] + "\n"
    end
  end
	value
end

def addUser(category, effects, discription, prise, current_tax)
  p = PostgresConnector.instance
  p.getConnector.prepare("insert_products", "insert into products (category, effects, discription, prise, current_tax) values ($1, $2, $3, $4, $5)")
  p.getConnector.exec_prepared("insert_products", [category, effects, discription, prise, current_tax])
end
