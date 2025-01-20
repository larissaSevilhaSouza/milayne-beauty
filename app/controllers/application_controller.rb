class ApplicationController < ActionController::Base
  before_action :page_info
  before_action :load_config
  before_action :load_socials
  before_action :top_link  
  before_action :load_most_viewed_posts


  def page_info
    set_meta_tags(
      site: "Milaine",
      title: "Página de Início"
    )
    
    image_path = Rails.root.join('app', 'assets', 'images', 'logo-top.svg')
    if File.exist?(image_path)
      set_meta_tags image_src: ActionController::Base.helpers.asset_path("logo-top.svg")
    end
  end
 

  private 
  
  def load_most_viewed_posts
    @most_viewed_posts = Post.joins(:post_views).group('posts.id').order('COUNT(post_views.id) DESC').limit(3)
  end
  
  def load_socials
    @socials = SocialMedium.all
  end

  def load_config
    @config = Adjustment.first 
  end

  def top_link
    @link_top = LinkTop.all
  end
 
end
