class AddBodyToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :body, :text
  end
end
