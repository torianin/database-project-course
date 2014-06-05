require './app/model'

def printProducts
	return "Działa"
	p = PostgresConnector.new()
	value = ""
	p.getProducts{|row| value = value + row['category'] + " " + row['effects'] + " " + row['discription']}
	value
end
