require './app/model'

def printProducts
	p = PostgresConnector.new()
	p.connect
	value = ""
	p.getProducts{|row| value = value + row['category'] + " " + row['effects'] + " " + row['discription']}
	p.disconnect
	value
end
