class PostsController < ApplicationController
  def index
    excluded_category = PostCategory.find_by(slug: "procuradoria-especial-da-mulher")
    @posts = Post.where("date_publish <= ? AND is_published = ?", Time.now, true).where.not(post_category_id: excluded_category&.id)
    @posts = @posts.order(date_publish: "DESC").page(params[:page]).per(6)
    
    set_meta_tags(
      title: "Notícias"
    )
  end

  def show
    @post = Post.find_by("slug = ? AND is_published = ? AND date_publish <= ?", params[:slug], true, Time.now)

    # @albums = @post.albums.first    

    if @post.nil?
      redirect_to root_path, alert: "Post não encontrado."
      return
    end

    unless PostView.exists?(post: @post, ip_address: request.remote_ip)
      PostView.create(post: @post, ip_address: request.remote_ip)
    end

    set_meta_tags(
      title: @post.title.titleize,
      description: @post.summary,
      og: {
        title: @post.title,
        description: @post.summary,
        image: @post.cover.cover.url,
        url: post_url(@post),
        type: 'Blog'
      }
    )
  end

  def by_category
    post_category = PostCategory.find_by(slug: params[:category])

    if post_category.nil?
      redirect_to root_path, alert: "Categoria não encontrada."
      return
    end

    @posts = Post.where(post_category_id: post_category.id, is_published: true).where("date_publish <= ?", Time.now)
    @posts = @posts.order(date_publish: "DESC").page(params[:page]).per(6)

    set_meta_tags(
      title: "Procuradoria Especial da Mulher"
    )
  end
end
