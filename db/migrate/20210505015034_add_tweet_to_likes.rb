class AddTweetToLikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :likes, :tweet, foreign_key: true
  end
end
