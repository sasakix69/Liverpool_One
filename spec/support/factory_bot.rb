RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

module SignInSupport
  def sign_in(user)
    visit user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    expect(current_path).to eq(tweets_path)
  end
end