class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :email
      t.string :profile_img
      t.string :name
      t.string :nickname

      t.timestamps
    end
  end
end
