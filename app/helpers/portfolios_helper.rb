module PortfoliosHelper
	def image_generator(height:, width:)
		"https://placeholdit.co//i/#{height}x#{width}"
	end

	def portfolio_img img, type
		if img && img.url.present?
			img.url
		elsif type == 'thumb'
			image_generator(height: '350', width: '200')
		elsif type == 'main'
			image_generator(height: '600', width: '400')
		end
	end
end


#self.main_image ||= Placeholder.image_generator(height: '600', width: '400')
		#self.thumb_image ||= Placeholder.image_generator(height: '350', width: '200')