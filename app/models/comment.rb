class Comment < ApplicationRecord
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true
  belongs_to :book
  belongs_to :user

  validates :content, presence: true

  scope :by_parent_nil, -> { where(parent: nil) }
  scope :by_child, -> { where.not(parent: nil) }
end
