require './app/model'

def printProducts
	p = PostgresConnector.new()
	value = ""
	p.getProducts{|row| value = value + row['category'] + " " + row['effects'] + " " + row['discription']}
	value
end
