class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :image
      t.text :description
      t.date :published_date
      t.decimal :price
      t.integer :status, null: false, default: 0
      t.references :author, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
