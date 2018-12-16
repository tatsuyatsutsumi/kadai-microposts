class Micropost < ApplicationRecord
  belongs_to :user
  
   has_many :likes
 # has_many :likings, through: :likes, source: :micropost これはuser.rbへの記載か？ここに記載がないと 下部のdef likingsが記載できない？
   has_many :likers, through: :reverses_of_like, source: :user 

  validates :content, presence: true, length: { maximum: 255 }
  
  def good(other_user) # likeだと中間テーブルと同名でまぎらわしいので変更
    unless self.user == other_user
      self.likes.find_or_create_by(user_id: other_user.id)
    end
  end

  def ungood(other_user)　# likeだと中間テーブルと同名でまぎらわしいので変更
    like = self.likes.find_by(user_id: other_user.id)
    like.destroy if like
  end

  def likings?(other_user)
    self.likings.include?(other_user)
  end
  
end