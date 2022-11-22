class BooksController < ApplicationController
  before_action :set_book, only: %i[show]

  def index
    @q = Book.ransack(params[:q])
    @pagy, @books = pagy(@q.result.includes(:author, image_attachment: :blob).newest)
    @authors = Author.all
    @suppliers = Supplier.all
    @categories = Category.all

    flash.now[:errors] = t('errors.books_not_found', search_param: params.dig(:q, :search_cont)) if @books.empty?
  end

  def show
    @comment = @book.comments.new
    @comments_total = @book.comments.count
    @similars = Book.includes(image_attachment: :blob).similars_author(@book.author).limit(BOOK_SIMILAR_NUMBER)
    @book_borrow = BookBorrow.new
  end

  private

  def set_book
    @book = Book.find(params[:id])
    @q_comment = @book.comments.ransack(params[:q])
    @pagy, @comments = pagy_countless(@q_comment.result.by_parent_nil.includes(:book, user: { avatar_attachment: :blob }), items: 5)
    render 'comments/scrollable_list' if params[:page]
    @replies = @book.comments.by_child
  end
end
