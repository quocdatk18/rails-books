class Book < ApplicationRecord
  has_one_attached :image

  has_many :book_borrows
  has_many :users, through: :book_borrows

  belongs_to :author
  belongs_to :supplier
  has_many :comments, dependent: :destroy 

  has_and_belongs_to_many :categories, join_table: 'books_categories'

  enum status: %i[available borrowed not_in_library]
  translate_enum :status

  ransack_alias :search, :title_or_description

  scope :newest, -> { order(updated_at: :desc) }
  scope :similars_author, ->(author) { where(author: author) }
end
