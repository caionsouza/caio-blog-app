class Article < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  
  belongs_to :user
  has_one_attached :avatar
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy

  has_rich_text :body

  private

  def self.add_categories(article, ids)
    ids.each { |id| article.categories << Category.find(id) }
  end

  def self.update_categories(article, ids)
    article.categories.delete_all if article.categories.present?
    ids.each { |id| article.categories << Category.find(id) }
  end
end
