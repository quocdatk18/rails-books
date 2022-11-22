class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :encrypted_password, null: false, default: ''
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string   :confirmation_token
      t.string   :unconfirmed_email
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :address
      t.integer :phone
      t.integer :role, default: 0
      t.string :last_name
      t.integer :gender
      t.boolean :is_actived
      t.string :first_name

      t.timestamps null: false
    end
  end
end
