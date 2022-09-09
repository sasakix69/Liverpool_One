require 'rails_helper'

RSpec.describe "Bookmarks", type: :system do

  before do
    @user = create(:user)
    @tweet = create(:tweet)
  end

  context 'いいねをクリックした場合', js: true do
    it 'いいねできる' do
      sign_in @user
      visit tweets_path
      find('.bookmark').click
      expect(page).to have_css('.unbookmark')
      expect(@tweet.bookmarks.count).to eq(1)
    end
  end
  context 'いいねを削除した場合', js: true do
    it 'いいねを取り消せる' do
      sign_in @user
      visit tweets_path
      find('.bookmark').click
      find('.unbookmark').click
      expect(page).to have_css('.bookmark')
      expect(@tweet.bookmarks.count).to eq(0)
    end
  end
end
