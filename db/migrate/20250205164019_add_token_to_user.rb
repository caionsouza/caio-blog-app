class AddTokenToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :token, :string
  end
end
