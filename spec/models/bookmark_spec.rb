require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  before do
    user = FactoryBot.create(:user)
    tweet = FactoryBot.create(:tweet, user:)
    @bookmark = FactoryBot.build(:bookmark, user_id: user.id, tweet_id: tweet.id)
  end

  describe 'いいね機能' do
    context 'いいねできる場合' do
      it 'user_idとtweet_idがあれば保存できる' do
        expect(@bookmark).to be_valid
      end

      it 'tweet_idが同じでもuser_idが違えばいいねできる' do
        another_bookmark = FactoryBot.create(:bookmark)
        expect(FactoryBot.create(:bookmark, user_id: another_bookmark.user_id)).to be_valid
      end

      it 'user_idが同じでもtweet_idが違えばいいねできる' do
        another_bookmark = FactoryBot.create(:bookmark)
        expect(FactoryBot.create(:bookmark, tweet_id: another_bookmark.tweet_id)).to be_valid
      end
    end

    context 'いいねできない場合' do
      it 'user_idが空ではいいねできない' do
        @bookmark.user_id = nil
        @bookmark.valid?
        expect(@bookmark.errors.full_messages).to include 'Userを入力してください'
      end

      it 'tweet_idが空ではいいねできない' do
        @bookmark.tweet_id = nil
        @bookmark.valid?
        expect(@bookmark.errors.full_messages).to include 'Tweetを入力してください'
      end
    end
  end
end
