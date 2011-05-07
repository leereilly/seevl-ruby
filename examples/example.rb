require 'rubygems'
require 'seevl-ruby'

artist = Seevl::Artist.find_by_id('KvGtyyFQ')
puts artist.name
puts artist.description
puts artist.origin
puts artist.related
puts artist.properties # display all available properties