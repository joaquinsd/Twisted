class LikesController < ApplicationController
  before_action :set_like, only: %i[ destroy ]

  # POST /likes or /likes.json
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = Like.new(like_params.merge(user: current_user))
    @like.tweet = @tweet

    respond_to do |format|
      if @like.save
        format.html { redirect_to root_path, notice: "Like was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Like was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit()
    end
end
