require ('pg')

require_relative('album.rb')
require_relative('../db/sql_runner.rb')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end


  def save
    sql = 'INSERT INTO artists (name) VALUES ($1) RETURNING id'
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update
    sql = 'UPDATE artists SET name = $1 WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    values = [@id]
    sql = 'DELETE FROM albums WHERE artist_id = $1'
    SqlRunner.run(sql, values)
    sql = 'DELETE FROM artists WHERE id = $1'
    SqlRunner.run(sql, values)
  end

  def find_albums
    sql = 'SELECT * FROM albums WHERE artist_id = $1'
    values = [@id]
    albums = SqlRunner.run(sql, values)
    albums.map { |album|Album.new(album)  }
  end



  def self.delete_all
    sql = 'DELETE FROM artists'
    SqlRunner.run(sql)
  end


  def self.find_all
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    artists.map { |artist| Artist.new(artist) }
  end

  def self.find_one(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artist = SqlRunner.run(sql, values)[0]
    artist = Artist.new(artist)
  end

end
