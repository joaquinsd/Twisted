class Api::ApiController < ActionController::API

  # def authenticate_user!
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == current_user && password == "123456"
  #   end
  #   warden.custom_failure! if performed?
  # end
  
  def create
    @tweet = Tweet.new(content: params[:content], user_id: params[:user_id])
    if @tweet.save
      render json: @tweet, status: :created
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def news
    render json: tweets_hash(Tweet.news)
  end

  def inbetween
    render json: tweets_hash(Tweet.inbetween(params[:start_date], params[:end_date]))
  end

  def tweets_hash(tweets)
    tweets_array = []
    tweets.each do |tw|
      tweet = {
        id: tw.id,
        content: tw.content,
        user_id: tw.user_id,
        like_count: tw.like_counter,
        retweets_count: tw.retweet_counter,
        retweetted_from: tw.tweet_id
      }
      tweets_array.push(tweet)
    end
    tweets_array
  end
end
