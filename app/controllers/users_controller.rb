class UsersController < ApplicationController
  before_action :set_user, only: [:bookmarks]

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(updated_at: :desc).page(params[:page]).per(15)
  end

  def bookmarks
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:tweet_id)
    @bookmark_tweets = current_user.bookmark_tweets.order(updated_at: :desc).page(params[:page]).per(15)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
