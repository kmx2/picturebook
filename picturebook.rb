#!/usr/bin/env ruby -w
# coding: utf-8

require 'fox16'
include Fox


require './photo'
require './photo_view'
require './album'
require './album_view'


class PictureBook < FXMainWindow
  
  @@photo_path="D:\\MyDocuments\\扫描照片\\昔日校园\\"
  
  def initialize( app )
    super( app, '相册', :width => 600, :height => 400 )
    
    add_menu_bar
    @album = Album.new("相册1")
    # @album.add_photo( Photo.new( @@photo_path+"273-1.jpg" ))
    # @album.add_photo( Photo.new( @@photo_path+"416-1.jpg" ))
    @album_view = AlbumView.new( self, @album )
  end
  
  def create
    super
    show( PLACEMENT_SCREEN )
  end
  
  def add_menu_bar
    menu_bar = FXMenuBar.new( self, LAYOUT_SIDE_TOP | LAYOUT_FILL_X )
    file_menu = FXMenuPane.new( self )
    FXMenuTitle.new( menu_bar, "文件", :popupMenu => file_menu )
    
    import_cmd = FXMenuCommand.new( file_menu, "导入照片...")
    import_cmd.connect( SEL_COMMAND ) do
      dialog = FXFileDialog.new( self, "导入照片...")
      dialog.selectMode = SELECTFILE_MULTIPLE
      dialog.patternList = ["JPEG图像(*.jpg,*.jpeg)"]
      if dialog.execute != 0
        import_photos( dialog.filenames )
      end
    end
  
    exit_cmd = FXMenuCommand.new( file_menu, "退出")
    exit_cmd.connect( SEL_COMMAND ) do
      exit
    end
  end
  
  def import_photos( filenames )
    filenames.each do |filename|
      photo = Photo.new( filename ) #.encoding_convert_to('UTF-8') )
      @album.add_photo( photo )
      @album_view.add_photo( photo )
    end
    @album_view.create
  end
  
    
  
end


if __FILE__ == $0
  FXApp.new do | app |
    PictureBook.new( app )
    app.create
    app.run
  end
end
