require( 'pg' )
require_relative('../db/sql_runner')
require('pry-byebug')

class Album

  attr_reader( :id, :name, :artist_id )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @artist_id = options['artist_id']
  end

  def save()
    sql = "INSERT INTO albums (name, artist_id) VALUES ('#{ @name }', #{ @artist_id }) RETURNING *"
    album = SqlRunner.run( sql ).first
    @id = album['id']
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = #{ @artist_id }"
    artist = SqlRunner.run( sql )
    result = Artist.new( artist.first )
    return result
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run( sql )
    result = albums.map { |s| Album.new( s ) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = #{id}"
    album = SqlRunner.run(sql)
    result = Album.new(album.first)
    return result
  end

  def self.update(options)
    sql = "UPDATE albums SET name = '#{options['name']}' WHERE id = #{options['id']}"
    SqlRunner.run(sql)
  end

  def self.destroy(id)
    sql = "DELETE FROM albums WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end

