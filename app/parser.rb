require './app/produkty'
require './app/string'

def parseString(message)
	splitedmessage = message.split
	case splitedmessage[0]
		when "p" then
			return $pomoc
		when "w" then 
			case splitedmessage[1]
			when "p" then
					return printProducts
			when "u" then
					return printUsers
			when "z" then
					return printQueries
			end
		when "d" then
      addProduct(splitedmessage[1],splitedmessage[2],splitedmessage[3],splitedmessage[4],splitedmessage[5])
      return $dodano
		when "e" then
			return

	end
end