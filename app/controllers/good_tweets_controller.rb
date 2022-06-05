class GoodTweetsController < ApplicationController
  def create
    if GoodTweet.where(user_id: current_user.id, tweet_id: params[:tweet_id]).present?
      judge = "false"
      tweet_id = params[:tweet_id]
      good_tweet_id =  GoodTweet.where(user_id: current_user.id, tweet_id: params[:tweet_id]).ids[0]
      render json: { judge: judge, tweet_id: tweet_id, good_tweet_id: good_tweet_id }
    else
      GoodTweet.create(user_id: current_user.id, tweet_id: params[:tweet_id])
      good_tweet_count = GoodTweet.where(tweet_id: params[:tweet_id]).count
      render json: { good_tweet_count: good_tweet_count }
    end
  end

  def destroy
    GoodTweet.find(params[:id]).destroy
    good_tweet_count = GoodTweet.where(tweet_id: params[:tweet_id]).count
    render json: { good_tweet_count: good_tweet_count }
  end
end
