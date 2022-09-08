require 'rails_helper'

RSpec.describe 'ツイート', type: :system do
  context 'ツイートができるとき' do
    before do
      user = create(:user)
      @tweet_body = Faker::Lorem.sentence
    end
    it 'ログインしたユーザーは新規投稿できる' do
      visit user_session_path
      fill_in 'Eメール', with: 'TEST@example.com'
      fill_in 'パスワード', with: 'testuser'
      click_on 'ログイン'
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('ツイートを投稿する')
      # 投稿作成ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      fill_in 'tweet[body]', with: @tweet_body
      # 送信するとtweetモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Tweet.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq(tweets_path)
      # トップページには先ほど投稿した内容の投稿が存在することを確認する
      expect(page).to have_content(@tweet_body)
    end
  end

  context 'ツイートができないとき' do
    it 'ログインしていないと新規ツイート投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('ツイートを投稿する')
    end
  end
end

RSpec.describe 'ツイートの編集', type: :system do
  before do
    user = create(:user)
    @tweet1 = FactoryBot.create(:tweet, user:)
    @tweet2 = FactoryBot.create(:tweet, user:)
  end
  context 'ツイートの編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した投稿の編集ができる' do
      # tweet1を投稿したユーザーでログインする
      sign_in(@tweet1.user)

      # 投稿ページに移動する
      visit tweet_path(@tweet1.id)

      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)

      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#tweet_body').value
      ).to eq(@tweet1.body)

      # 投稿内容を編集する
      fill_in 'tweet_body', with: "#{@tweet1.body}+編集したツイート"

      execute_script('window.scrollBy(0,10000)')
      # 編集してもtweetモデルのカウントは変わらないことを確認する
      expect do
        find_button('ツイートする').hover.click
      end.to change { Tweet.count }.by(0)

      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(tweet_path(@tweet1))
      # トップページには先ほど変更した内容の投稿が存在することを確認する
      visit tweets_path
      expect(page).to have_content("#{@tweet1.body}+編集したツイート")
    end
  end
  context 'ツイートの編集ができないとき' do
    it 'ログインしたユーザーは自分以外がツイートした投稿の編集画面には遷移できない' do
      # ログインする
      sign_in(@tweet1.user)

      # tweet2を投稿したユーザーとして投稿ページに遷移する
      visit tweet_path(@tweet2.id)

      # 「編集」ボタンがないことを確認する
      expect(page).to have_no_link('button-edit-#{@tweet1.id}'), href: edit_tweet_path(@tweet1)
    end
    it 'ログインしていないと投稿の編集画面には遷移できない' do
      # 投稿ページに移動する
      visit tweet_path(@tweet1.id)

      # tweet1に「編集」ボタンがないことを確認する
      expect(page).to have_no_link('button-edit-#{@tweet1.id}'), href: edit_tweet_path(@tweet1)
    end
  end
end

RSpec.describe 'ツイートの削除', type: :system do
  before do
    user = create(:user)
    @tweet1 = FactoryBot.create(:tweet, user:)
    @tweet2 = FactoryBot.create(:tweet, user:)
  end
  context '投稿の削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した投稿の削除ができる' do
      # tweet1を投稿したユーザーでログインする
      sign_in(@tweet1.user)

      # 投稿ページに移動する
      visit tweet_path(@tweet1.id)

      # 投稿を削除するとレコードの数が1減ることを確認する
      link = find('.trash')
      link.click

      expect do
        expect(page.driver.browser.switch_to.alert.text).to eq '削除しますか？'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ツイートを削除しました'
      end.to change { Tweet.count }.by(-1)

      # 削除完了画面に遷移したことを確認する
      expect(current_path).to eq(tweets_path)

      # トップページにはtweet1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content("#{@tweet1.body}")
    end
  end
  context '投稿が削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した内容の削除ができない' do
      # tweet2を投稿したユーザーとして投稿ページに遷移する
      visit tweet_path(@tweet2.id)

      # tweet2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_selector('.trash'), href: tweet_path(@tweet1)
    end
    it 'ログインしていないと投稿の削除ボタンがない' do
      # 投稿ページに移動する
      visit tweet_path(@tweet1.id)

      # tweet1に「削除」ボタンがないことを確認する
      expect(page).to have_no_selector('.trash'), href: tweet_path(@tweet1)
    end
  end
end
