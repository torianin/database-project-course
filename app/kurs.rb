require 'open-uri'
require 'json'

def getBitcoinValue 
	message_hash = JSON.parse(open("https://blockchain.info/pl/ticker").read())
	return "#{message_hash["EUR"]["15m"].to_s + message_hash["EUR"]["symbol"].to_s}\n#{message_hash["USD"]["15m"].to_s +  message_hash["USD"]["symbol"].to_s}\n#{message_hash["PLN"]["15m"].to_s +  message_hash["PLN"]["symbol"].to_s}\n"
end