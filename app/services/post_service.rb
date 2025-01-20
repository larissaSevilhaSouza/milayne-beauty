module PostService
	def get_post
		@get_posts = []

		url = 'https://crcms.org.br/feed/'
		xml_data = URI.open(url).read
		doc = Nokogiri::XML(xml_data)
			
		doc.xpath('//item').each do |item|
			title = item.xpath('title').text
			link = item.xpath('link').text
			pubDate = item.xpath('pubDate').text
			creator = item.xpath('dc:creator', 'dc' => 'http://purl.org/dc/elements/1.1/').text
			category = item.xpath('category').text
			description = item.xpath('description').text
			content_encoded = item.xpath('content:encoded', 'content' => 'http://purl.org/rss/1.0/modules/content/').text
			
			description_text = Nokogiri::HTML(description).text
			description_text = CGI.unescapeHTML(description_text)
			content_encoded_doc = Nokogiri::HTML(content_encoded)
			first_image_url = content_encoded_doc.css('img').first&.attr('src')

			date = DateTime.parse(pubDate)
    	pubDate = date.strftime('%d/%m/%Y %H:%M:%S')
			
			post = {
				title: title,
				link: link,
				pub_date: pubDate,
				creator: creator,
				category: category,
				description: description_text,
				description_original: description,
				content_encoded: content_encoded,
				cover: first_image_url
			}
			
			@get_posts << post
		end
		return @get_posts
	end
end
