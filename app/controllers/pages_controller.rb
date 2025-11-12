class PagesController < ApplicationController
  def home
  	@posts = Blog.all rescue []
  	@skills = Skill.all rescue []
  end

  def about
    @skills = Skill.all rescue []
  end

  def contact
  end

  def tech_news
  	@tweets = SocialTool.twitter_search rescue []
  end

end
