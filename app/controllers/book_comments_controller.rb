class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if comment.save
      redirect_to request.referer, notice: "You have posted comment successfully"
    else
      @book = Book.find(params[:book_id])
      @user = current_user
      @book_comments = @book.book_comments.all
      @book_comment = comment
      render "books/show"
    end
  end
  
  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to request.referer, notice: "You have destroyed comment successfilly"
  end
  
  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
