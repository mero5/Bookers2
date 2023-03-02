class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  #def create
    #followed = current_user.relationships.build(follower_id: params[:user_id])
    #followed.save
    #redirect_to request.referrer
  #end

  #def destroy
    #followed = current_user.relationships.find_by(follower_id: params[:user_id])
    #followed.destroy
    #redirect_to request.referrer
  #end
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
