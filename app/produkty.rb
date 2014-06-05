require './app/model'

def printProducts
	p = PostgresConnector.instance
	puts p
	value = ""
	p.getProducts{|row| value = value + row['category'] + " " + row['effects'] + " " + row['discription']}
	value
end
