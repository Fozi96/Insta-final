class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :profile_image
      t.string :name
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end
end
