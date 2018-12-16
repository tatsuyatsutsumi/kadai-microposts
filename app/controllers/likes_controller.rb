class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @micropost.iine(current_user)
    flash[:success] = 'ポストをいいねしました。'
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    @micropost.ungood(current_user)
    flash[:success] = 'ポストのいいねを削除しました。'
  end
end
