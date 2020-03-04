require('pg')

require_relative('artist.rb')
require_relative('../db/sql_runner.rb')

class Album

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i

  end


  def save
    sql = "INSERT INTO albums
    (
      title,
      genre,
      artist_id
      )
      VALUES
      ($1, $2, $3
        )
        RETURNING id"
        values = [@title, @genre, @artist_id]
        @id = SqlRunner.run(sql, values)[0]["id"].to_i
      end


      def find_artist
        sql = 'SELECT * FROM artists WHERE id = $1'
        values = [@artist_id]
        artist = SqlRunner.run(sql, values).first
        Artist.new(artist)
      end




    def self.delete_all
      sql = "DELETE FROM albums"
      SqlRunner.run(sql)
end

def self.find_all
  sql = "SELECT * FROM albums"
  albums = SqlRunner.run(sql)
  albums.map { |album| Album.new(album) }
end



end
