class UsersController < ApplicationController
  before_action :set_user, only: [:bookmarks]

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(updated_at: :desc).page(params[:page]).per(15)
    @relationship = current_user.relationships.find_by(follow_id: @user.id)
    @set_relationship = current_user.relationships.new
  end

  def bookmarks
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:tweet_id)
    @bookmark_tweets = current_user.bookmark_tweets.order(created_at: :desc).page(params[:page]).per(15)
  end

  # フォローしている全てのユーザーを取得
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  # 全てのフォロワーを取得
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
