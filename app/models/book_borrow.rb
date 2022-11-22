class BookBorrow < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :user, :book, :from, :to, presence: true
  validate :from_date_not_in_past, :to_date_after_from_date, :book_can_borrow, on: :create

  enum status: %i[requested borrowing returned canceled out_of_date]
  translate_enum :status

  private

  def from_date_not_in_past
    return unless from&.past?

    errors.add(:from, 'Can not in the past')
  end

  def to_date_after_from_date
    return unless to <= from

    errors.add(:to, 'Return day invalid')
  end

  def book_can_borrow
    return if book.available?

    errors.add(:book, 'Book can not borrow')
  end
end
