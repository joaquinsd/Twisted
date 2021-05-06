class Tweet < ApplicationRecord
  has_many :likes
  belongs_to :user
  validates :content, presence: true
  paginates_per 50


  def user_pic
    user.profile_pic
  end

  def author
    user.username
  end

  def like_counter
    likes.count
  end


  
  # def retweet_counter
  #   retweet.count  
  # end
end
