require './app/string'

def parseString(message)
	splitedmessage = message.split
	case splitedmessage[0]
		when "pomoc" then
			return $pomoc

		when "wyloguj" then
			return "#term.logout();term.clear();"

		when "alert" then
			return "#alert(\"Operacja niedozwolona !!\");"

		when "wyświetl" then 
			case splitedmessage[1]
			when "produkty" then
					return printProducts
			when "użytkowników" then
					return printUsers
			when "zapytania" then
					return printQueries
			end


		when "dodaj" then
			case splitedmessage[1]
			when "p" then
				addProduct(splitedmessage[2],splitedmessage[3],splitedmessage[4],splitedmessage[5],splitedmessage[6])
			when "u" then
				addUser(splitedmessage[2], splitedmessage[3], splitedmessage[4], splitedmessage[5])
			end
      return $dodano


		when "e" then
			return

    when "i" then


	end
end