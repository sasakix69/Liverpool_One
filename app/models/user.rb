class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable

  validates :username, presence: true
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # throughオプションでbookmarkテーブルを経由してuserモデルとアソシエーションを作成して、bookmark_tweetsは仮のテーブル名なので、sourceオプションで参照するテーブルを指定している
  has_many :bookmark_tweets, through: :bookmarks, source: :tweet

  mount_uploader :avatar, AvatarUploader

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      username: auth.info.nickname,
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20],
      # carrierwaveのアップローダーを:avatarにマウントさせてるのでクロスドメインで情報を取得する場合、avatar:からremote_avatar_urlに変更
      remote_avatar_url: auth.info.image
    )
    # ダミーメールに承認メールが送られてしまうので、送られないように設定
    user.skip_confirmation!
    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def own?(object)
    id == object.user_id
  end

  # <<演算子でbookmarks.create!(tweet_id: tweet.id)と同様の処理を行う
  def bookmark(tweet)
    bookmark_tweets << tweet
  end

  def unbookmark(tweet)
    bookmark_tweets.destroy(tweet)
  end

  # ログインしているユーザーに紐づいたブックマークのレコードに引数で渡された掲示板モデルと紐づいたレコードが存在するか。存在すればユーザーはその掲示板をブックマークしていると判定、存在しなければブックマークされていないと判定できる
  def bookmark?(tweet)
    bookmark_tweets.include?(tweet)
  end
end
