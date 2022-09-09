require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  before do
    @user = create(:user)
    @tweet = create(:tweet)
  end

  context 'コメントした時', js: true do
    it 'コメントがajaxで表示される' do
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
      # 新規コメントページへのリンクがない
      expect(page).to have_no_content('コメントを投稿')
    end
  end
end

RSpec.describe 'コメントの編集', type: :system do
  before do
    user = create(:user)
    @tweet1 = create(:tweet, user:)
    @comment1 = create(:comment, user:)
    @comment2 = create(:comment, user:)
  end

    context 'コメントの編集ができるとき', js: true do
      it 'ログインしたユーザーは自分がコメントしたコメントの編集ができる' do
        # comment1をコメントしたユーザーでログインする
        sign_in(@comment1.user)
        visit tweet_path(@tweet1.id)
        fill_in 'comment[body]', with: 'テストコメント'
        click_on 'コメントを投稿'
        expect(page).to have_content 'テストコメント'
        # コメント内容を編集する
        find('.js-edit-comment-button').click
        find(".mb-1").set("#{@comment1.body}+編集したコメント")
        execute_script('window.scrollBy(0,10000)')
        # 編集してもtweetモデルのカウントは変わらないことを確認する
        expect do
          find_button('更新').hover.click
        end.to change { Comment.count }.by(0)
        # 編集完了画面に遷移したことを確認する
        expect(current_path).to eq(tweet_path(@tweet1.id))
        # ツイート詳細ページには先ほど変更した内容のコメントが存在することを確認する
        expect(page).to have_content("#{@comment1.body}+編集したコメント")
      end
  end

    context 'コメントの編集ができないとき' do
      it 'ログインしたユーザーは自分以外がしたコメントの編集画面には遷移できない' do
        # ログインする
        sign_in(@comment1.user)
        visit tweet_path(@tweet1.id)
        fill_in 'comment[body]', with: 'テストコメント'
        click_on 'コメントを投稿'
        expect(page).to have_content 'テストコメント'
        # comment2をコメントしたユーザーとしてコメントページに遷移する
        sign_in(@comment2.user)
        visit tweet_path(@tweet1.id)
        # 「編集」ボタンがないことを確認する
        expect(page).to have_no_link('.js-edit-comment-button')
      end
    end
end

RSpec.describe 'コメントの削除', type: :system do
    before do
      user = create(:user)
      @comment1 = FactoryBot.create(:comment, user:)
      @comment2 = FactoryBot.create(:comment, user:)
    end

    context 'コメントの削除ができるとき' do
      it 'ログインしたユーザーは自らがコメントしたコメントの削除ができる' do
        # comment1をコメントしたユーザーでログインする
        sign_in(@comment1.user)

        # コメントページに移動する
        visit comment_path(@comment1.id)

        # コメントを削除するとレコードの数が1減ることを確認する
        link = find('.trash')
        link.click

        expect do
          expect(page.driver.browser.switch_to.alert.text).to eq '削除しますか？'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'コメントを削除しました'
        end.to change { Tweet.count }.by(-1)

        # 削除完了画面に遷移したことを確認する
        expect(current_path).to eq(tweets_path)

        # トップページにはcomment1の内容が存在しないことを確認する（テキスト）
        expect(page).to have_no_content("#{@comment1.body}")
      end
    end

    context 'コメントが削除ができないとき' do
      it 'ログインしたユーザーは自分以外がコメントした内容の削除ができない' do
        # comment2をコメントしたユーザーとしてコメントページに遷移する
        visit comment_path(@comment2.id)

        # comment2に「削除」ボタンが無いことを確認する
        expect(page).to have_no_selector('.trash'), href: comment_path(@comment1)
      end
      it 'ログインしていないとコメントの削除ボタンがない' do
        # コメントページに移動する
        visit comment_path(@comment1.id)

        # comment1に「削除」ボタンがないことを確認する
        expect(page).to have_no_selector('.trash'), href: comment_path(@comment1)
      end
    end
end
