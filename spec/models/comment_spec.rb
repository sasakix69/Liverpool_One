require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    user =  create(:user)
    tweet = create(:tweet)
    @comment = build(:comment, user_id: user.id, tweet_id: tweet.id)
  end

  describe 'コメント機能' do
    context 'コメントを保存できる場合' do
      it 'コメント文を入力済みであれば保存できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントを保存できない場合' do
      it 'コメントが空では投稿できない' do
        @comment.body = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include 'コメントを入力してください'
      end

      it 'ユーザーがログインしていなければコメントできない' do
        @comment.user_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include 'Userを入力してください'
      end

      it '投稿したものがなければコメントできない' do
        @comment.tweet_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include 'Tweetを入力してください'
      end
    end
  end
end
