require './app/string'
require './app/mailer'
require './app/kurs'

require 'pusher'
Pusher.url = "http://0b6500a2c511ef6a91ba:81572065aa966eb9805d@api.pusherapp.com/apps/76635"

def parseString(message)
	message = message.gsub(/\(.*?\)/, '')
	splitedmessage = message.split
	case splitedmessage[0]
		when "kluski" then
			return "#setTimeout(function() { alert(\"Kluski gotowe\"); }, 600000);alert(\"Przypomne Ci za 10 min\");"

		when "pomoc" then
			return $pomoc

		when "wyloguj" then
			return "#term.logout();term.clear();"

		when "reset" 
			if isAdmin?
				createModel
				return $zresetowano
			else
				return "#alert(\"Operacja niedozwolona !!\");"
			end

		when "wyświetl" then 
			case splitedmessage[1]
			when "produkty" then
					return printProducts
			when "kierowców" then
				return printDrivers
			when "użytkowników" then
				if isAdmin?
					return printUsers
				else
					return "#alert(\"Operacja niedozwolona !!\");"
				end
			when "zapytania" then
				if isAdmin?
					return printQueries
				else
					return "#alert(\"Operacja niedozwolona !!\");"
				end
			when "płatności" then
				if isAdmin?
					return printOrders
				else
					return "#alert(\"Operacja niedozwolona !!\");"
				end
			end

		when "dodaj" then
			case splitedmessage[1]
			when "produkt" then
				if splitedmessage.size == 2
		     Pusher['test_channel'].trigger("#{session[:session_id]}", {
		        message: '#var term = $(\'#term\').terminal();term.insert(\'dodaj produkt (kategoria) (efekt) (opis) (cena) (podatek)\');'
		      })
				else
					addProduct(splitedmessage[2],splitedmessage[3],splitedmessage[4],splitedmessage[5],splitedmessage[6])
					return $dodano
				end
			when "użytkownika" then
				if splitedmessage.size == 2
		     Pusher['test_channel'].trigger("#{session[:session_id]}", {
		        message: '#var term = $(\'#term\').terminal();term.insert(\'dodaj użytkownika (mail) (login) (password) (rola c=klient, s=sprzedawca, a=admin, d=kierowca)\');'
		      })
				else
					addUser(splitedmessage[2], splitedmessage[3], splitedmessage[4], splitedmessage[5])
					return $dodano
				end
			end

		when "kup" then
			session[:shoppingcart] << splitedmessage[1]
      return "Dodano. Aktualnie w koszyku #{session[:shoppingcart]}. Aby sfinalizować zakup napisz finalizuj"

		when "finalizuj" then
			if session[:shoppingcart] == []
      	return "Masz pusty koszyk."
    	end

		when "edytuj" then
			case splitedmessage[1]
				when "produkt" then
					if splitedmessage.size == 3
						produkt = getProductById(splitedmessage[2].to_i)
				     Pusher['test_channel'].trigger("#{session[:session_id]}", {
				        message: '#var term = $(\'#term\').terminal();term.insert(\'dodaj produkt'+produkt["category"]+ '(kategoria)'+produkt["effects"]+ ' (efekt)'+produkt["discription"]+ ' (opis)'+produkt["prise"]+ '  (cena)'+produkt["current_tax"]+ ' (podatek)\');'
				      })
					else
						editProduct(splitedmessage[3],splitedmessage[4],splitedmessage[5],splitedmessage[6],splitedmessage[2])
			   end
				when "użytkownika" then
					
			end

		when "kurs" then
			return getBitcoinValue

    when "zaproś" then
			m = Mailer.instance
			m.createMail(splitedmessage[1], 'Witamy w tajnej społeczności.', 'Aby dokończyć proces rejestracji')
			return $zaproszono
	end
end