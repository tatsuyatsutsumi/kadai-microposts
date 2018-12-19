class Micropost < ApplicationRecord
  belongs_to :user
  
  has_many :likes
  has_many :likings, through: :likes, source: :user

  validates :content, presence: true, length: { maximum: 255 }
  
  def good(other_user)
      self.likes.find_or_create_by(user_id: other_user.id)
  end

  def ungood(other_user)
    like = self.likes.find_by(user_id: other_user.id)
    like.destroy if like
  end

  def liking?(other_user)
    self.likings.include?(other_user)
  end
  
end