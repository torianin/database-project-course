require './app/string'
require './app/mailer'

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
			when "produkt" then
				addProduct(splitedmessage[2],splitedmessage[3],splitedmessage[4],splitedmessage[5],splitedmessage[6])
			when "użytkownika" then
				addUser(splitedmessage[2], splitedmessage[3], splitedmessage[4], splitedmessage[5])
			end
      return $dodano

		when "kup" then
			case splitedmessage[1]
			when "produkt" then
				addProduct(splitedmessage[2],splitedmessage[3],splitedmessage[4],splitedmessage[5],splitedmessage[6])
			end
      return $dodano

		when "edytuj" then
			return

    when "zaproś" then
			m = Mailer.instance
			m.createMail(splitedmessage[1], 'Witamy w tajnej społeczności narkomanów.', 'Aby dokończyć proces rejestracji wejdź w linka http://database-project-course.herokuapp.com/')
			return $zaproszono
	end
end