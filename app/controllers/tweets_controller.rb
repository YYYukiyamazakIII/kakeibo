class TweetsController < ApplicationController
  def index
    @tweets = Tweet.includes(:user, :comments, :good_tweets).order('created_at DESC')
    @good_tweet = GoodTweet.new
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

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      if @tweet.update(tweet_params)
        redirect_to action: :index
      else
        render 'edit'
      end
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      if tweet.destroy
        redirect_to action: :index
      end
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(tweet_id: params[:id]).includes(:user).order('created_at DESC')
  end

  def search
    @tweets = Tweet.search(params[:keyword])
    @good_tweet = GoodTweet.new
  end

  def tweet_params
    params.require(:tweet).permit(:text, :image).merge(user_id: current_user.id)
  end

end
