require './web'

run Sinatra::Application

#run Rack::URLMap.new({
#  "/" => Protected
#})