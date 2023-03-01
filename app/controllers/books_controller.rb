class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    #左下book/新規作成
    @book = Book.new
    #左上プロフィール
    @user = current_user
    #すべてのbooks
    @books = Book.all
    #bookのを投稿したuser
    
  end

  def show
    #左下book/新規作成
    @book_new = Book.new
    @book = Book.find(params[:id])
    #左上プロフィール、bookを投稿した人
    @user = @book.user
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    @book = Book.find(params[:id])
    #unless bookを投稿したuserのid == ログインしているuserのid
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
