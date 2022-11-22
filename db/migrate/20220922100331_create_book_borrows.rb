class CreateBookBorrows < ActiveRecord::Migration[7.0]
  def change
    create_table :book_borrows do |t|
      t.integer :status
      t.date :from
      t.date :to
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
