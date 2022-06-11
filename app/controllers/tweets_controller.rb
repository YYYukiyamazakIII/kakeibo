class TweetsController < ApplicationController

  before_action :set_good_tweet, only: [:index, :show, :search]
  before_action :find_tweet, only: [:edit, :update, :destroy, :show]

  def index
    @tweets = Tweet.includes(:user, :comments, :good_tweets).order('created_at DESC')
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
  end

  def update
    if @tweet.user_id == current_user.id
      if @tweet.update(tweet_params)
        redirect_to action: :index
      else
        render 'edit'
      end
    end
  end

  def destroy
    if @tweet.user_id == current_user.id
      if @tweet.destroy
        redirect_to action: :index
      end
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(tweet_id: params[:id]).includes(:user).order('created_at DESC')
  end

  def search
    @tweets = Tweet.search(params[:keyword]).order('created_at DESC')
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text, :image).merge(user_id: current_user.id)
  end

  def set_good_tweet
    @good_tweet = GoodTweet.new
  end

  def find_tweet
    @tweet = Tweet.find(params[:id])
  end

end
