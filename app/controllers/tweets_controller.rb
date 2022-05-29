class TweetsController < ApplicationController
  def index
    @tweets = Tweet.includes(:user).order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to action: :index
    else
      render 'new'
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.destroy && tweet.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:text, :image).merge(user_id: current_user.id)
  end

end
