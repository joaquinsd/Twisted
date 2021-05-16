class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends, class_name: 'Friend', foreign_key: 'user_id', dependent: :destroy
  has_many :friended_by, class_name: 'Friend', foreign_key: 'friend_user_id'

  after_commit :friend_self, on: :create


  def to_s
    username
  end

  def friend_self
    friend(self)
  end

  def friend(other_user)
    unless friends?(other_user)
      Friend.create(user: self, friend_user: other_user)
    end
  end

  def unfriend(other_user)
    if friends?(other_user)
      friends.where(friend_user: other_user).destroy_all
    end
  end

  def friends?(other_user)
    friends.where(friend_user: other_user).any?
  end

  def friendship_toggler(other_user)
    if friends?(other_user)
      unfriend(other_user)
    else
      friend(other_user)
    end
  end

  def friend_users
    friends.map(&:friend_user_id)
  end

  def suggested_friends
    User.where.not(id: friends.map(&:friend_user_id)).limit(4)
  end


  def tweet_counter
    tweets.count
  end

  def retweet_counter
    tweets.retweets.size
  end

  def like_counter
    likes.count
  end

end
