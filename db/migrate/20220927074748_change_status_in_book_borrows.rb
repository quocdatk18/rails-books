class ChangeStatusInBookBorrows < ActiveRecord::Migration[7.0]
  def change
    change_table :book_borrows do |t|
      t.change :status, :integer, null: false, default: 0
    end
  end
end
