class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :encrypted_password
      t.datetime :remember_created_at

      t.timestamps
    end
  end
end
