module BookBorrowsHelper
  def show_borrow_status(book_borrow)
    if book_borrow.canceled? || book_borrow.out_of_date?
      'text-danger'
    elsif book_borrow.borrowing?
      'text-success'
    else
      'text-secondary'
    end
  end
end
