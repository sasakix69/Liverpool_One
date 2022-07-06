class BookmarksController < ApplicationController
  before_action :authenticate_user!

  # ブックマークボタンをクリックされたツイートを取得して、Userモデルのインスタンスメソッドとして作成したbookmarkメソッドの引数に渡してブックマークする
  def create
    @tweet = Tweet.find(params[:tweet_id])
    current_user.bookmark(@tweet)
    # redirect_back fallback_location: root_path, success: t('.success')
  end

  # ログインしているユーザーに関連づいてクリックしたbookmarksモデルに関連づいたtweetモデルを取得してunbookmarkメソッドの引数に渡してブックマーク解除をしている
  def destroy
    @tweet = current_user.bookmarks.find(params[:id]).tweet
    current_user.unbookmark(@tweet)
    # redirect_back fallback_location: root_path, success: t('.success')
  end
end
