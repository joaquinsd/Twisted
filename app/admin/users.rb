ActiveAdmin.register User do
  includes :tweets, :likes, :friends
  permit_params :email, :username, :profile_pic, :password


  index do
    column :id
    column :username
    column :email
    column :profile_pic
    column :created_at
    column :friend_counter
    column :tweet_counter
    column :retweet_counter
    column :like_counter
  
    actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username, :profile_pic
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username, :profile_pic]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
