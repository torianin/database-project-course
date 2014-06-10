require 'rubygems'
require 'geokit'
require 'openssl'

a = gets.chomp
first_place = Geokit::Geocoders::GoogleGeocoder.geocode '#{a}'

b = gets.chomp
second_place=Geokit::Geocoders::GoogleGeocoder.geocode '#{b}'

puts a.distance_to(b)