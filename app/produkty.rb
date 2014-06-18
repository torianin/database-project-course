require './app/model'

def category(category)
  categories = {
    "0" => "niszczące mózg", 
    "1" => "wywołujące strach przed szaleństwem", 
    "2" => "złodzieje marzeń", 
    "3" => "wampiry emocjonalne", 
    "4" => "powodujące szybkie nieregularne bicie serca", 
    "5" => "pozbawiające uczucia wyspania pomimo dostatecznej długości snu", 
    "6" => "kopiujące osobowość",
    "7" => "raj hedonistów",
    "8" => "prowadzące do nawracających zaburzeń percepcji"
  }
  return categories[category]
end

def effect(effect)
  effects = {
    "0" => "gniew", 
    "1" => "smutek", 
    "2" => "beznadziejność", 
    "3" => "rozczarowanie", 
    "4" => "obojętność", 
    "5" => "samotność", 
    "6" => "upokorzenie", 
    "7" => "zaskoczenie", 
    "8" => "zażenowanie", 
    "9" => "bezsilność"
  }
  return effects[effect]
end

def printProducts
	p = PostgresConnector.instance
	value = "Id :\tKategoria : \tEfekt : \tOpis :\t"
  p.getConnector.exec( "SELECT * FROM products" ) do |result|
    result.each do |row|
      value = value + "\n" + row['id_product'] + "\t" + category(row['category']) + "\t" + effect(row['effects']) + "\t" + row['discription']
    end
  end
	value
end

def addProduct(category, effects, discription, prise, current_tax)
  p = PostgresConnector.instance
  p.getConnector.exec_prepared("insert_products", [category, effects, discription, prise, current_tax])
end

