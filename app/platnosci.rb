require './app/model'

	def printOrders
	p = PostgresConnector.instance
  @rows = []
  p.getConnector.exec( "SELECT * FROM payment" ) do |result|
    result.each do |row|
      @rows << [row['id_payment'],row['value'],row['currency']]
    end
  end
  table = Terminal::Table.new :headings => ['Id','Wartość','Waluta'], :rows => @rows
  table.to_s
end

def addOrder(value)
  p = PostgresConnector.instance
  p.getConnector.exec_prepared("insert_order", [value])
end