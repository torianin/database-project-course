require './app/model'

def printProducts
	p = PostgresConnector.instance
	puts p
	value = ""
  p.getConnector.exec( "SELECT * FROM products" ) do |result|
    result.each do |row|
      value = value + row['category'] + " " + row['effects'] + " " + row['discription']
    end
  end
	value
end

def addProduct(category, effects, discription, prise, current_tax)
  p = PostgresConnector.instance
  p.getConnector.prepare("insert_products", "insert into products (category, effects, discription, prise, current_tax) values ($1, $2, $3, $4, $5)")
  p.getConnector.exec_prepared("insert_products", [category, effects, discription, prise, current_tax])
end

