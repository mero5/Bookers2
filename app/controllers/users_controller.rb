class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  
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
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    @user = current_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(@user.id)
    end
  end
  
  def followings
    user = User.find(params[:id])
    @user = user.followings
  end
  
  def followers
    user = User.find(params[:id])
    @user = user.followers
  end
  
end
