require 'sinatra'
require 'pg'

get '/' do
	conn = PG::Connection.open(:dbname => ENV['DATABASE_URL'])
end
