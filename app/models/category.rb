class Category < ApplicationRecord
  has_many :books

  has_and_belongs_to_many :books, join_table: 'books_categories'

  validates :name, presence: true, uniqueness: true
  validates :description, length: { maximum: 150 }
end
