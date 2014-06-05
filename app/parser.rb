def parseString(message)
	splitedmessage = message.split
	case splitedmessage[0]
		when "p" then
			return $pomoc
		when "a" then
			return 
		when "" then
			return
	end
end