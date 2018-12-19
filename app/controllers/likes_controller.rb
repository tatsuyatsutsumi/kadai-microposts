class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    micropost = Micropost.find(params[:micropost_id]) 
    micropost.good(current_user)
    flash[:success] = 'お気に入りしました。'
    redirect_to current_user
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    micropost.ungood(current_user)
    flash[:success] = 'お気に入りを削除しました。'
    redirect_to current_user
  end
end
