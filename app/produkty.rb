require './app/model'

def printProducts
	p = PostgresConnector.new()
	puts p
	value = ""
	p.getProducts{|row| value = value + row['category'] + " " + row['effects'] + " " + row['discription']}
	value
end
