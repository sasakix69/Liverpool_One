require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '#create' do
    context 'comment関連の通知' do
      before do
        @comment = build(:comment)
        @tweet = build(:tweet)
      end

      it 'コメントが行われた場合に保存できる' do
        notification = build(:notification, comment_id: @comment.id, action: 'comment')
        expect(notification).to be_valid
      end

      it '投稿にいいねが行われた場合に保存できる' do
        notification = build(:notification, tweet_id: @tweet.id, action: 'bookmark')
        expect(notification).to be_valid
      end

      it '投稿にコメントが行われた場合に保存できる' do
        notification = build(:notification, tweet_id: @tweet.id, action: 'comment')
        expect(notification).to be_valid
      end

      context 'フォロー関連の通知' do
        it 'フォローが行われた場合に保存できる' do
          user1 = build(:user)
          user2 = build(:user)
          notification = build(:notification, visitor_id: user1.id, visited_id: user2.id, action: 'follow')
          expect(notification).to be_valid
        end
      end
    end

    describe 'アソシエーションのテスト' do
      let(:association) do
        described_class.reflect_on_association(target)
      end

      context 'tweetモデルとのアソシエーション' do
        let(:target) { :tweet }

        it 'tweetとの関連付けはbelongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end
      end

      context 'commentモデルとのアソシエーション' do
        let(:target) { :comment }

        it 'commentとの関連付けはbelongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end
      end

      context 'visitorとのアソシエーション' do
        let(:target) { :visitor }

        it 'Visitorとの関連付けはbelongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end
      end

      context 'visitedとのアソシエーション' do
        let(:target) { :visited }

        it 'Visitedとの関連付けはbelongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end
      end
    end
  end
end
