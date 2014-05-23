require 'sinatra'
require './app/model'

get '/' do
	"Hello word"
end

get '/admin' do
	createModel
end