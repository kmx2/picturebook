

require "./photo_view"

class AlbumView < FXMatrix
  
  attr_reader :album
  
  def initialize( p, album )
    super( p, :opts => LAYOUT_FILL )
    @album = album
    @album.each_photo { |photo| add_photo( photo )}
  end
  
  def add_photo( photo )
    PhotoView.new( self, photo )
  end
end