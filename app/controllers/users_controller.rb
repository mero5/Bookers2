class UsersController < ApplicationController
  def index
    #左下book/新規作成
    @book = Book.new
    #左上プロフィール
    @user = current_user
    #全てのusersを出力
    @users = User.all
  end

  def show
    #左下book/新規作成
    @book = Book.new
    #左上プロフィール
    @user = User.find(params[:id])
    #上のuserだけのbooks
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
