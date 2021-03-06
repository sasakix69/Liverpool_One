class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable, :omniauthable

  validates :username, presence: true
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # throughオプションでbookmarkテーブルを経由してuserモデルとアソシエーションを作成して、bookmark_tweetsは仮のテーブル名なので、sourceオプションで参照するテーブルを指定している
  has_many :bookmark_tweets, through: :bookmarks, source: :tweet
  # active_notifications：自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # passive_notifications：相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :relationships
  # フォローしているuserを取得
  has_many :followings, through: :relationships, source: :follow
  # followingsテーブルからフォローしている人のデータを取得
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # userテーブルから自分をフォローしているuserを取得
  has_many :followers, through: :reverse_of_relationships, source: :user

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

  # パスワード無しでユーザープロフィールを更新する
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
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

  # ログインしているユーザーに紐づいたブックマークのレコードに引数で渡されたツイートモデルと紐づいたレコードが存在するか。存在すればユーザーはそのツイートをブックマークしていると判定、存在しなければブックマークされていないと判定できる
  def bookmark?(tweet)
    bookmark_tweets.include?(tweet)
  end

  # 既にフォローされている場合にフォローが重複して保存されることを防ぐ
  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  # フォローしていればフォローできないようにする
  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  # フォローしている user を取得し、include?(other_user)によって自分自身が含まれていないかを確認
  def following?(other_user)
    followings.include?(other_user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
