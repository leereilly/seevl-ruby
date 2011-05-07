require 'rubygems'
require 'seevl-ruby'

puts '-- Finding an artist by its id'
artist = Seevl::Artist.find_by_id('KvGtyyFQ')
puts 'Name : ' + artist.name
puts 'Description : ' + artist.description
puts 'Origin : ' + artist.origin.to_s
puts 'Other available properties: ' + artist.properties.to_s

puts ''

puts '-- Searching for an artist, and accessing recommendations'
artists = Seevl::Artist.find_all_by_name('weezer')
puts 'ID of the first match : ' + artists[0].name
puts 'Related artists :'
artists[0].related.each do |artist|
  puts artist.name
end

puts 'Top related artist of the top related artist: ' + artists[0].related[0].related[1].name + ' - ' + artists[0].related[0].related[1].uri
