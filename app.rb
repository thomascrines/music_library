require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/album') 
require_relative('./models/artist') 

require_relative('./controllers/album_controller.rb')
require_relative('./controllers/artist_controller.rb')