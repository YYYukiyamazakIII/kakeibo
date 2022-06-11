class GoodTweetsController < ApplicationController
  def create
    if GoodTweet.where(user_id: current_user.id, tweet_id: params[:tweet_id]).present?
      render json: { judge: "false", tweet_id: params[:tweet_id], good_tweet_id: GoodTweet.where(user_id: current_user.id, tweet_id: params[:tweet_id]).ids[0] }
    else
      GoodTweet.create(user_id: current_user.id, tweet_id: params[:tweet_id])
      render json: { good_tweet_count: GoodTweet.where(tweet_id: params[:tweet_id]).count }
    end
  end

  def destroy
    GoodTweet.find(params[:id]).destroy
    render json: { good_tweet_count: GoodTweet.where(tweet_id: params[:tweet_id]).count }
  end
end
