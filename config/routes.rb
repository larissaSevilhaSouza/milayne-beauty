Rails.application.routes.draw do 
  get 'oxoplastia/index'
  get 'store/index'
  root 'home#index'

  # Route for healthcheck
  get "/up/", to: "up#index", as: :up
  get "/up/databases", to: "up#databases", as: :up_databases

  # Rails Admin
  devise_for :users
  mount RailsAdmin::Engine => '/gestao-gov', as: 'rails_admin'

  post 'increment_quick_access_views/:id', to: 'application#increment_quick_access_views', as: :increment_quick_access_views

  #about
  get "sobre-nos", to: "about#index", as: :about 

  get "galeria-oxtoplastia", to: "gallery_ox#index", as: :gallery_ox 
  

  # Contact
  post 'fale-conosco' => 'contacts#create', as: :create_contact
  get 'fale-conosco' => 'contacts#index', as: :contact

  get "busca" => "searchs#index", as: :search

  # Uploader for ckeditor
  post '/post_images/upload/:model/:model_id' => 'post_images#upload'
  # Delete for ckeditor
  post '/post_images/delete/:post_image_id' => 'post_images#delete'

  # # Posts
  get "noticias/" => "posts#index", as: "posts"
  get "noticias/:slug" => "posts#show", as: "post"
  get "noticias/categoria/:category" => "posts#by_category", as: "posts_category"

  # # Album
  get "galerias" => "albums#index", as: :albums
  get "galerias/:slug" => "albums#show", as: :album

  get "galerias/:slug/adicionar-foto" => "albums#new_photo", as: :new_photo

  post "galerias/:slug/create_photo" => "albums#create_photo", as: :album_create_photo
 
  get 'category/:category', to: 'albums#category', as: 'category'


  #videos
  get "videos" => "videos#index", as: :videos
  get "video/:slug" => "videos#show", as: :video
 
end
