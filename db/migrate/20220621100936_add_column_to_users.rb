class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image, :string
    add_column :users, :kop_history, :integer
    add_column :users, :favorite_player, :string
  end
end
