class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :city
      t.string :country
      t.date :birth
      t.boolean :gender
      t.integer :role
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
