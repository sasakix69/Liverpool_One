class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      username: auth.info.nickname,
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )
    # ダミーメールに承認メールが送られてしまうので、送られないように設定
    user.skip_confirmation!
    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
