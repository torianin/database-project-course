require './app/produkty'

def parseString(message)
	splitedmessage = message.split
	case splitedmessage[0]
		when "p" then
			return $pomoc
		when "w" then 
			return printProducts
		when "d" then
			return
		when "e" then
			return

	end
end