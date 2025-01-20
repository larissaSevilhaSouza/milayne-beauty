class PostImagesController < ApplicationController
  def upload
    if params[:model] == "post"
      model = Post.find(params[:model_id])
    elsif params[:model] == "page"
      model = Page.find(params[:model_id])
    end

    post_image = model.post_images.build(url: params[:upload])

    if post_image.save
      render json: { url: post_image.url.to_s }
    else
      render json: { error: "Erro ao salvar imagem" }, status: :unprocessable_entity
    end
  end

  def delete
    post_image = PostImage.find_by(id: params[:post_image_id])
    if post_image.present?
      if post_image.destroy
        render json: { success: true }
      else
        render json: { error: 'Erro ao excluir a imagem' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Imagem não encontrada' }, status: :not_found
    end
  end
end
