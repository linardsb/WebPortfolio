module DefaultPageContent
	extend ActiveSupport::Concern

	included do 
		before_action :set_page_defaults
	end
	
  def set_page_defaults
  	@page_title = "Linards Berzins | WebPortfolio"
  	@seo_keywords = "Linards Berzins web portfolio"
  end
end