class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: %i[edit update destroy]

  def index
    @tweets = Tweet.all.includes(:user).order(created_at: :desc).page(params[:page]).per(15)
    # @search = Tweet.ransack(params[:q])
    # @tweets = @search.result(distinct: true).includes(%i[user bookmarks]).order(created_at: :desc).page(params[:page])
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to tweets_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet.id), success: t('defaults.message.updated', item: Tweet.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Tweet.model_name.human)
      render :edit
    end
  end

  def destroy
    @tweet.destroy!
    redirect_to tweets_path, success: t('defaults.message.destroyed', item: Tweet.model_name.human)
  end

  # def bookmarks
  # @search = current_user.bookmark_tweets.ransack(params[:q])
  # @bookmark_tweets = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  # end

  private

  def set_tweet
    @tweet = current_user.tweets.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:body, :tweet_image, :tweet_image_cache).merge(user_id: current_user.id)
  end
end
