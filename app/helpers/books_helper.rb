module BooksHelper
  def name_and_published_date(author_name, published_date)
    "#{author_name}(#{published_date})"
  end

  def show_status(book)
    if book.available? && current_user
      t('.borrow')
    else
      Book.translated_status(book.status)
    end
  end

  def can_borrow?(book)
    current_user && book.available?
  end

  def button_borrow_attributes(book)
    if can_borrow?(book)
      { class: 'btn btn-outline', data: { bs_toggle: 'modal', bs_target: '#modal_borrow_book' } }
    else
      { class: 'btn btn-secondary', disabled: true }
    end
  end

  def request_borrow?(user, book)
    BookBorrow.where(user: user, book: book, status: :requested).any?
  end
end
