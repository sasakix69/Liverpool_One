class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @tweet = @comment.tweet
    respond_to do |format|
      if @comment.save
        @tweet.create_notification_comment!(current_user, @comment.id)
        format.js { flash.now[:notice] = t('.success') }
      else
        format.js { flash.now[:error] = t('.fail') }
      end
    end
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_update_params)
      render json: { comment: @comment }, status: :ok
    else
      render json: { comment: @comment, errors: { messages: @comment.errors.full_messages } }, status: :bad_request
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(tweet_id: params[:tweet_id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
end
