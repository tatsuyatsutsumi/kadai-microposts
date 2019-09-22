class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def show
    @micropost = Micropost.find_by(id: params[:id])
    redirect_to :root if @micropost.blank?
  end
  
  def edit
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.blank?
      redirect_to :root
    elsif @micropost.user_id != current_user.id
      redirect_to :root
    end
  end

  def update
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:success] = 'メッセージを編集しました。'
      redirect_to :root
    else
      @micropost.valid?
      flash.now[:danger] = 'メッセージの編集に失敗しました。'
      render action: :edit
    end
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
end