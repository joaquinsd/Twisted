class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy like retweet]

  def index
    @q = Tweet.tweets_for_me(current_user).ransack(params[:q])
    @tweets = @q.result.order(created_at: :desc).page(params[:page])
    @tweet = Tweet.new
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
    end
  end

  def like
    @tweet.like_toggler(current_user)

    respond_to do |format|
      if @tweet.liked?(current_user)
        format.html { redirect_to root_path, notice: 'Tweet liked' }
      else
        format.html { redirect_to root_path, notice: 'Tweet unliked' }
      end
    end
  end

  def retweet
    retweet = @tweet.retweet(current_user)
    respond_to do |format|
      if retweet.save
        format.html { redirect_to root_path, notice: 'Retweet Successful!' }
      else
        format.html { redirect_to root_path, notice: 'Retweet Unsuccessful :-(' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
