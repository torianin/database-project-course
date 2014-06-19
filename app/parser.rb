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
				case splitedmessage[2]
					when "tanie" then
						return printCheapProducts
					when "dobre" then
						return printExensiveProducts
				end
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
				if isAdmin? or isSeller?
					if splitedmessage.size == 2
			     Pusher['test_channel'].trigger("#{session[:session_id]}", {
			        message: '#var term = $(\'#term\').terminal();term.insert(\'dodaj produkt (kategoria) (efekt) (opis) (cena) (podatek)\');'
			      })
					else
						addProduct(splitedmessage[2],splitedmessage[3],splitedmessage[4],splitedmessage[5],splitedmessage[6])
						return $dodano
					end
				else
					return "#alert(\"Operacja niedozwolona !!\");"
				end
			when "użytkownika" then
				if isAdmin?
					if splitedmessage.size == 2
			     Pusher['test_channel'].trigger("#{session[:session_id]}", {
			        message: '#var term = $(\'#term\').terminal();term.insert(\'dodaj użytkownika (mail) (login) (password) (rola c=klient, s=sprzedawca, a=admin, d=kierowca)\');'
			      })
					else
						addUser(splitedmessage[2], splitedmessage[3], splitedmessage[4], splitedmessage[5])
						return $dodano
					end
				else
					return "#alert(\"Operacja niedozwolona !!\");"
				end
			end

		when "kup" then
			produkt = getProductById(splitedmessage[1].to_i)
			session[:shoppingcart] << produkt[:discription].to_s
			#session[:payment] = session[:payment] + produkt[:prise_with_tax].to_i
      return "Dodano. Aktualnie w koszyku #{session[:shoppingcart]} o wartości #{session[:payment]}. Aby sfinalizować zakup napisz finalizuj"

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
				        message: '#var term = $(\'#term\').terminal();term.insert(\'edytuj produkt '+produkt[:id].to_s+'(id) ' + produkt[:category].to_s+ '(kategoria) '+produkt[:effects].to_s+ '(efekt) '+produkt[:discription].to_s+ '(opis) '+produkt[:prise].to_s+ '(cena) '+produkt[:current_tax].to_s+ '(podatek)\');'
				      })
					else
						editProduct(splitedmessage[2],splitedmessage[3],splitedmessage[4],splitedmessage[5],splitedmessage[6],splitedmessage[7])
			      return "Zaktualizowano produkt."
			   end
				when "użytkownika" then
					if splitedmessage.size == 3
						użytkownik = getUserById(splitedmessage[2].to_i)
				     Pusher['test_channel'].trigger("#{session[:session_id]}", {
				        message: '#var term = $(\'#term\').terminal();term.insert(\'edytuj użytkownika '+użytkownik[:id].to_s+'(id) ' + użytkownik[:mail].to_s+ '(mail) '+użytkownik[:login].to_s+ '(login) (hasło) '+użytkownik[:role].to_s+ '(rola)\');'
				      })
					else
						editUser(splitedmessage[2],splitedmessage[3],splitedmessage[4],splitedmessage[5],splitedmessage[6])
			      return "Zaktualizowano użytkownika."
			   end
			end

		when "kurs" then
			return getBitcoinValue

    when "zaproś" then
			m = Mailer.instance
			m.createMail(splitedmessage[1], 'Witamy w tajnej społeczności narkomanów.', 'Aby dokończyć proces rejestracji wyślij zwrotnego maila zawierającego login i współrzędne miejsca dostarczenia przesyłki ( poprawny format danych -> 51.109406, 17.047482).')
			return $zaproszono
	end
end