class Tweet < ApplicationRecord
  has_many :likes
  belongs_to :user
  validates :content, presence: true


  def user_pic
    user.profile_pic
  end

  def like_counter
    likes.count
  end
  
  # def retweet_counter
  #   retweet.count  
  # end
end
