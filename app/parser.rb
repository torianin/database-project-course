require './app/string'

def parseString(message)
	message.downcase
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
			when "p" then
					return printProducts
			when "u" then
					return printUsers
			when "z" then
					return printQueries
			end


		when "d" then
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