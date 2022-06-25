class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :body, null: false
      t.string :tweet_image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
