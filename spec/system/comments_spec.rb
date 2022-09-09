require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @user = create(:user)
    @tweet = create(:tweet)
  end

  context 'コメントした時' do
    it 'コメントがajaxで表示される', js: true do
      sign_in(@user)
      visit tweet_path(@tweet.id)
      fill_in 'コメント', with: 'テストコメント'
      click_on 'コメントを投稿'
      expect(page).to have_content('コメントを作成しました')
      expect(page).to have_content('テストコメント')
    end
  end  

  context 'コメント出来ない時' do
    it 'ログインしていないとコメントできない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('コメントを投稿する')
    end
  end
end
