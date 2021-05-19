class Api::ApiController < ActionController::API
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
