class ChangeDataTypeToGender < ActiveRecord::Migration[7.2]
  def change
    change_column(:profiles, :gender, :string)
  end
end