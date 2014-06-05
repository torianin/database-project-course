require './app/model'

def category(category)
	case category
	  when "0" then return "Stymulant"
    when "1" then return "Depresant"
    when "2" then return "Psychodelik"
	end
end

def effect(effect)
  case effect
    when "0" then return "Uczucie odprężenia"
    when "1" then return "Słabsza reakcja na ból"
    when "2" then return "Euforia"
    when "3" then return "Senność"
    when "4" then return "Błogostan"
    when "5" then return "Brak potrzeby snu"
    when "6" then return "Widzisz dźwięki i słyszysz kolory"
    when "7" then return "Podniecenie"
    when "8" then return "Urojenie i halucynacje wzrokowe"
  end
end

def printProducts
	p = PostgresConnector.instance
	puts p
	value = ""
  p.getConnector.exec( "SELECT * FROM products" ) do |result|
    result.each do |row|
      value = value +"Kategoria : " + category(row['category']) + "\nEfekt : " + effect(row['effects']) + "\nOpis : " + row['discription']
    end
  end
	value
end

def addProduct(category, effects, discription, prise, current_tax)
  p = PostgresConnector.instance
  p.getConnector.prepare("insert_products", "insert into products (category, effects, discription, prise, current_tax) values ($1, $2, $3, $4, $5)")
  p.getConnector.exec_prepared("insert_products", [category, effects, discription, prise, current_tax])
end

