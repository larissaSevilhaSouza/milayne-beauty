class HomeController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
	include PostService

  def index
      @link_top = LinkTop.order(created_at: :desc).limit(5)
      @contact = Contact.new
      @banners = Banner.all 
      @about = About.first 
      @socials = SocialMedium.all
      @ox = Oxoplastium.all
      @gallery_ox = GalleryOx.all
      @config = Adjustment.first 
      @posts = Post.where("date_publish <= ? AND is_published = ?", Time.now, true).order(date_publish: "DESC")
      @featured_posts = Post.where(featured: true).order(date_publish: "DESC").limit(5)
      @non_featured_posts = Post.where(featured: false).order(date_publish: "DESC")
      @albuns = Album.where(featured: true).order(created_at: :desc).limit(4)
      @videos = Video.where(featured: true).order(created_at: :desc).limit(3)
      @schedule = ScheduleYourAppointment.all
    end
end
