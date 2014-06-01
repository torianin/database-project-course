require './web'

run Rack::URLMap.new({
  "/" => Protected
})