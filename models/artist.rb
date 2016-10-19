require( 'pg' )
require_relative( '../db/sql_runner' )
require_relative( '../models/album' )

class Artist

  attr_reader( :id, :name )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{ @name }') RETURNING *"
    artist = SqlRunner.run( sql ).first
    @id = artist['id']
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{ @id }"
    albums = SqlRunner.run( sql )
    result = albums.map { |a| Album.new( a ) }
    return result
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run( sql )
    result = artists.map { |a| Artist.new( a ) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = #{id}"
    artist = SqlRunner.run(sql)
    result = Artist.new(artist.first)
    return result
  end

  def self.update(options)
    sql = "UPDATE artists SET
    name = '#{options['name']}' WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  def self.destroy(id)
    sql = "DELETE FROM artists WHERE id = #{id}"
    SqlRunner.run(sql)
  end
end
