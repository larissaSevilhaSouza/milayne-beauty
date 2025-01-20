module ApplicationHelper
  def ads_head
    @head_ads = Adsense.where(ad_type: 0, status: true)
  end

  def ads_body
    @body_ads = Adsense.where(ad_type: 1, status: true)
  end

  def ads_footer
    @footer_ads = Adsense.where(ad_type: 2, status: true)
  end

  def site_colors
    SiteColor.first_or_create(
      primary: "#FFFFFF",
      sencondary: "#FFFFFF",
      terciary: "#FFFFFF"
    )
  end

  def google_font_url(font_name)
    "https://fonts.googleapis.com/css2?family=#{CGI.escape(font_name).gsub('+', '%20')}:wght@100..900&display=swap"
  end

  def format_phone_number(number)
    number.gsub(/\D/, '')  
  end
end
