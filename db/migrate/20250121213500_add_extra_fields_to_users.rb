class AddExtraFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :birth, :date
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :gender, :boolean
    add_column :users, :role, :integer
  end
end
