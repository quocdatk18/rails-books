class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]
  before_action :set_book
  before_action :set_comment, only: %i[edit update destroy]

  def new; end

  def create
    @comment = current_user.comments.new(cmt_params.merge(book_id: @book.id))
    respond_to do |format|
      if @comment.save
        format.js
        format.html { redirect_to book_path(@book), notice: 'Comment was successfully created' }
        format.json { render :show, status: :created, location: @book }
      else
        format.js
        format.html { redirect_to book_comments_path(@book) }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @comment.update(cmt_params)
        format.js
        format.html { redirect_to book_path(@book), notice: 'Comment was successfully update' }
      else
        format.js { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment&.destroy
        format.html { redirect_to book_path(@book), notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
        format.js   { render layout: false }
      else
        format.html { redirect_to book_path(@book), notice: 'Comment was faill destroyed.' }
      end
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_comment
    @comment = @book.comments.find(params[:id])
  end

  def cmt_params
    params.require(:comment).permit(:parent_id, :content)
  end
end
