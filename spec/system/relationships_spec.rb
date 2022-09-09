require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  before do
    @user1 = create(:user)
    @user2 = create(:user)
  end

  describe '#create,#destroy' do
    it 'ユーザーをフォロー、フォロー解除できる' do
      # @user1としてログイン
      sign_in(@user1)

      # @user1として@user2詳細ページへ遷移する
      visit user_path(@user2.id)
      
      # @user2をフォローする
      expect(page).to have_button('フォローする')
      click_on('フォローする')
      expect(page).to have_button('フォローを解除する')
      expect(@user2.followers.count).to eq(1)
      expect(@user1.followings.count).to eq(1)

      # @user2をフォロー解除する
      expect(page).to have_button('フォローを解除する')
      click_on('フォローを解除する')
      expect(page).to have_button('フォローする')
      expect(@user2.followers.count).to eq(0)
      expect(@user1.followings.count).to eq(0)
    end
  end
end
