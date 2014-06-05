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
