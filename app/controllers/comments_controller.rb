class CommentsController < ApplicationController
  def create
    @comment = current_user.authored_comments.new(comment_params)
    @comment.link_id = params[:link_id]
    @comment.parent_comment_id = params[:comment_id]

    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to link_url(@comment.link)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.try(:destroy)

    redirect_to link_url(@comment.link)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end


