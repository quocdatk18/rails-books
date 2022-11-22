class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatables, :confirmable, :rememberable, :recoverable

  has_one_attached :avatar

  has_many :book_borrows
  has_many :books, through: :book_borrows
  has_many :comments, dependent: :destroy

  enum gender: %i[male female other]

  validates :password, presence: true, confirmation: true, on: :create
  validates :gender, presence: true
  validates :phone, numericality: { only_integer: true }
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    length: { maximum: 100 }, uniqueness: true

  def active_for_authentication?
    super && is_actived?
  end
end
