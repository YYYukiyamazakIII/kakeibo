class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    if comment.save
      name = comment.user.name
      time = comment.created_at.to_s.slice(0..18)
      text = comment.text
      render json:{ name: name, time: time, text: text }
    else
      judge = false
      message = comment.errors.full_messages
      render json:{ judge: judge, message: message }
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
