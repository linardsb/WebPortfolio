class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_sidebar_topics
	layout 'blog'
  access all: [:index, :show], site_admin: :all

  def index
  	@topics = Topic.all
  end

  def show
    @blogs = @topic.blogs.recent.page(params[:page]).per(5)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_path, notice: 'Topic was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topics_path, notice: 'Topic was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_path, notice: 'Topic was successfully deleted.' }
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title)
  end

  def set_sidebar_topics
    @side_bar_topics = Topic.with_blogs
  end
end
