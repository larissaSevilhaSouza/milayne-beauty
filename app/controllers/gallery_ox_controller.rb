class GalleryOxController < ApplicationController
  def index
      @gallery_ox = GalleryOx.all
  end
end
