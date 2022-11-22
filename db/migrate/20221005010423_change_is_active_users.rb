class ChangeIsActiveUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :is_actived, :boolean, default: true
  end
end
