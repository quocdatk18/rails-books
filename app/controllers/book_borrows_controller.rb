class BookBorrowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book_borrows, only: %i[index update]
  before_action :set_book_borrow, only: :update

  def index; end

  def create
    @book_borrow = BookBorrow.new(book_borrow_params.merge(user: current_user))
    respond_to do |format|
      if @book_borrow.save
        format.js {}
        format.json { render 'books/show', status: :created, location: @book_borrow.book }
      else
        format.json { render json: @book_borrow.errors, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    if @book_borrow.update(status: :canceled)
      flash[:errors] = t('.success')
      redirect_to book_borrows_path
    else
      flash.now[:errors] = t('errors.messages.can_not_cancel')
      render :index
    end
  end

  private

  def book_borrow_params
    params.require(:book_borrow).permit(:book_id, :from, :to)
  end

  def set_book_borrows
    @q = current_user.book_borrows.ransack(params[:q])
    @pagy, @book_borrows = pagy(@q.result.includes(:book))
  end

  def set_book_borrow
    @book_borrow = BookBorrow.find(params[:id])
  end
end
