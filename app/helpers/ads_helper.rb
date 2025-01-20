module AdsHelper
  def banners_ads(width, height, position, amount, popup = nil)
    format_ad = FormatAd.where(width: width, height: height, position: position)
    query = Banner.where(format_ad: format_ad, status: true)

    if popup
      query = query.order(:id).limit(amount)
    else
      query = query.order(id: :desc).limit(3)
    end

    query
  end

  def show_banner_ad(banner, width, height, class_link = "", class_img = "")
    unless banner.nil?
      if banner.code_client_adsense.blank?
        if banner.link.present?
          return link_to external_link(banner.link), target: target(banner), class: class_link do
            image_tag banner.photo.url, class: class_img if banner.photo.present?
          end
        else
          image_tag banner.photo.url, class: class_img if banner.photo.present?
        end
      elsif banner.extension == "swf" && banner.file_ad.present?
        return swf_object banner.file_ad.to_s, width, height
      else
        adsense_tag(
          client: banner.code_client_adsense,
          slot: banner.code_slot_adsense,
          dimension: banner.format_ad.width.to_s << "x" << banner.format_ad.height.to_s
        )
      end
    end
  end

  def swf_object(swf, width, height)
    "<embed src='#{swf}' width='#{width}' height='#{height}' wmode='transparent' />"&.html_safe
  end

  def target(banner)
    if banner.link.present?
      banner.target ? "_blank" : "_self"
    else
      ""
    end
  end

  def remove_in_mobile(banner)
    return "banner--flash" if banner.code_client_adsense.present? || banner.extension == "swf"
  end

  def external_link(url)
    if url.present?
      url.include?("http://") || url.include?("https://") ? url : url.insert(0, "http://")
    else
      "javascript:void(0)"
    end
  end
end
