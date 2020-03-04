require("pry-byebug")
require_relative("../models/album.rb")
require_relative("../models/artist.rb")

Album.delete_all
Artist.delete_all


artist1 = Artist.new({
  'name' => 'GloryHammer'
  })

artist1.save

artist2 = Artist.new({
  'name' => 'Justin Bieber'
  })

artist2.save

album1 = Album.new({
  'title' => 'Space 1992',
  'genre' => 'Interdimensional Space Metal',
  'artist_id' => artist1.id
  })

album1.save

album2 = Album.new({
  'title' => 'Tales from the kingdom of fife',
  'genre' => 'Interdimensional Space Metal',
  'artist_id' => artist1.id
  })

album2.save

album3 = Album.new({
  'title' => 'Believe',
  'genre' => 'generic pop',
  'artist_id' => artist2.id
  })

album3.save

binding.pry
nil
