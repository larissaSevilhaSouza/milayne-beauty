class VideosController < ApplicationController
  def index
    @videos = Video.order(date_publish: "DESC").page(params[:page]).per(12)

    set_meta_tags(
      title: "Vídeos",
    )
  end

  def show
    @video = Video.find_by_slug(params[:slug])

    set_meta_tags(
      title: @video.title,
    )
  end
end
