class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  def user_pic
    user.profile_pic
  end
end
