class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if comment.save
      redirect_to request.referer
    else
      render "/books"
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to books_path
  end

end