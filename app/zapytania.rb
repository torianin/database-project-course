require './app/model'

	def printQueries
	p = PostgresConnector.instance
	puts p
	value = ""
  p.getConnector.exec( "SELECT * FROM query" ) do |result|
    result.each do |row|
      value = value +"Zapytanie = " + row['query_text'] + row['date'] + "\n"
    end
  end
	value
end

	def addQuery(query)
    	@conn.exec_prepared("insert_query", [query])
	end