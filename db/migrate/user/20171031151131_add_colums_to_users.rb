class AddColumsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :profile_img, :string
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :bio, :string
    add_column :users, :url, :string
    add_column :users, :location, :string
  end
end
