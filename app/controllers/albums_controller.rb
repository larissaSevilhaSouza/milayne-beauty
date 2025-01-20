class AlbumsController < ApplicationController
  def index
    @albums = Album.order(date_publish: "DESC").page(params[:page]).per(6)
    
    set_meta_tags(
      title: "Álbuns",
    )
  end

  def show
    @album = Album.find_by_slug(params[:slug])

    if @album.nil?
      redirect_to "/404"    
    end

    set_meta_tags(
      title: @album.title,
    )
  end

  def new_photo
    @album = Album.find_by_slug(params[:slug])
  
    if @album.nil?
      redirect_to "/404"
    else
      @photo = Photo.new
    end
  end

  def create_photo
    @album = Album.find_by_slug(params[:slug])
   
    if @album.nil?
      redirect_to "/404"
    else      
      @photo = Photo.new
      @photo.image = params[:file]
      @photo.album_id = @album.id 
      @photo.save      
    end
  end
 
  def category
    @category = params[:category]
    @albums = Album.where(album_category: AlbumCategory.find_by(name: @category))

    set_meta_tags(
      title: "Álbuns - #{@category}",
    )
  end 

  private
  
  def photo_params
    params.require(:photo).permit(:image)
  end
end