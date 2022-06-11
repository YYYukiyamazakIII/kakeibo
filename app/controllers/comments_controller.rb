class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json:{ name: comment.user.name, date: comment.created_at.strftime('%Y-%m-%d %H:%M'), text: comment.text }
    else
      render json:{ judge: "false", message: comment.errors.full_messages }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user_id == current_user.id
      comment.destroy
    end
  end

  def comment_params
    params.require(:comment).permit(:text).merge(tweet_id: params[:tweet_id], user_id: current_user.id)
  end
end
