class RemoveAllLeftAttributesLeftFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_columns(:users, :birth, :city, :country, :gender, :role)
  end
end
