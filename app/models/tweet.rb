class Tweet < ApplicationRecord
  has_many :likes
  belongs_to :user
  validates :content, presence: true
  paginates_per 50

  def user_pic
    user.profile_pic
  end

  def like(user)
    Like.create(user: user, tweet: self)
  end

  def unlike(user)
    likes.where(user: user).destroy_all
  end

  def liked?(user)
    likes.where(user: user).size.positive?
  end

  def like_toggler(user)
    if liked?(user)
      unlike(user)
    else
      like(user)
    end
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
