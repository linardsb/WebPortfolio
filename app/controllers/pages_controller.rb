class PagesController < ApplicationController
  def home
  	@posts = Blog.all rescue []
  	@skills = Skill.all rescue []

  	respond_to do |format|
      format.html { render template: 'pages/home' }
    end
  end

  def about
    @skills = Skill.all rescue []

    respond_to do |format|
      format.html { render template: 'pages/about' }
    end
  end

  def contact
    respond_to do |format|
      format.html { render template: 'pages/contact' }
    end
  end

  def tech_news
  	@tweets = SocialTool.twitter_search rescue []

  	respond_to do |format|
      format.html { render template: 'pages/tech_news' }
    end
  end

end
