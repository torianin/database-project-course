require 'rubygems'
require 'openssl'
require 'geokit'

Geokit::default_units = :kms
Geokit::default_formula = :sphere

#a = gets.chomp
first_place = Geokit::Geocoders::GoogleGeocoder.geocode '51.109406, 17.047482' # Wrocław
puts first_place.ll

#b = gets.chomp
second_place=Geokit::Geocoders::GoogleGeocoder.geocode '50.057771, 19.942240' #Krakow
puts second_place.ll
puts first_place.distance_to(second_place)
