class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.references :parent

      t.timestamps
    end
  end
end
