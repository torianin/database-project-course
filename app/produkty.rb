require './app/model'
require 'rubygems'
require 'terminal-table'

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
  @rows = []
  value = ""
  p.getConnector.exec( "SELECT * FROM products" ) do |result|
    result.each do |row|
      @rows << [row['id_product'],category(row['category']),effect(row['effects']),row['discription'],row['prise_with_tax'],row['seller_id']]
    end
  end
	table = Terminal::Table.new :headings => ['Id','Kategoria','Efekt','Opis','Cena','Sprzedawca'], :rows => @rows
  table.to_s
end

def printCheapProducts
  p = PostgresConnector.instance
  @rows = []
  value = ""
  p.getConnector.exec( "SELECT * FROM Cheap_products" ) do |result|
    result.each do |row|
      @rows << [row['id_product'],category(row['category']),effect(row['effects']),row['discription'],row['prise_with_tax'],row['seller_id']]
    end
  end
  table = Terminal::Table.new :headings => ['Id','Kategoria','Efekt','Opis','Cena','Sprzedawca'], :rows => @rows
  table.to_s
end

def printExensiveProducts
  p = PostgresConnector.instance
  @rows = []
  value = ""
  p.getConnector.exec( "SELECT * FROM Expensive_products" ) do |result|
    result.each do |row|
      @rows << [row['id_product'],category(row['category']),effect(row['effects']),row['discription'],row['prise_with_tax'],row['seller_id']]
    end
  end
  table = Terminal::Table.new :headings => ['Id','Kategoria','Efekt','Opis','Cena','Sprzedawca'], :rows => @rows
  table.to_s
end

def getProductById(id)
  p = PostgresConnector.instance
  info = Hash.new
  if isAdmin? 
    p.getConnector.exec( "SELECT * FROM products WHERE id_product = #{id} " ) do |result|
      result.each do |row|
        info = { :id => row['id_product'], :category => row['category'], :effects => row['effects'], :discription => row['discription'], :prise => row['prise'], :current_tax => row['current_tax'], :prise_with_tax => row['prise_with_tax'], :seller_id => row['seller_id']}
      end
    end
  elsif isSeller?
    p.getConnector.exec( "SELECT * FROM products WHERE id_product = #{id} and seller_id = #{session[:login]} " ) do |result|
      result.each do |row|
        info = { :id => row['id_product'], :category => row['category'], :effects => row['effects'], :discription => row['discription'], :prise => row['prise'], :current_tax => row['current_tax'], :prise_with_tax => row['prise_with_tax'], :seller_id => row['seller_id']}
      end
    end
  end
  info
end

def addProduct(category, effects, discription, prise, current_tax)
  p = PostgresConnector.instance
  p.getConnector.exec_prepared("insert_products", [category, effects, discription, prise, current_tax,session[:login]])
end

def editProduct(id_, category_, effects_, discription_, prise_, current_tax_)
  p = PostgresConnector.instance
  p.getConnector.exec_prepared("update_products", [category_, effects_, discription_, prise_, current_tax_, id_])
end
