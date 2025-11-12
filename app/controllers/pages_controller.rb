class PagesController < ApplicationController
  def home
  	@posts = Blog.all rescue []
  	@skills = Skill.all rescue []

  	respond_to do |format|
      format.html
    end
  end

  def about
    @skills = Skill.all rescue []

    respond_to do |format|
      format.html
    end
  end

  def contact
    respond_to do |format|
      format.html
    end
  end

  def tech_news
  	@tweets = SocialTool.twitter_search rescue []

  	respond_to do |format|
      format.html
    end
  end

end
