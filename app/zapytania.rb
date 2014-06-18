require './app/model'

	def printQueries
	p = PostgresConnector.instance
  @rows = []
  p.getConnector.exec( "SELECT * FROM query" ) do |result|
    result.each do |row|
      @rows << [row['query_text'],row['date']]
    end
  end
  table = Terminal::Table.new :headings => ['Zapytanie','Data'], :rows => @rows
  table.to_s
end

def addQuery(query)
  p = PostgresConnector.instance
  p.getConnector.exec_prepared("insert_query", [query])
end