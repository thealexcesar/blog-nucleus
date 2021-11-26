class CommentsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]]
  def create
    @post.comments.create! comments_params
    # CommentsMailer.submitted(comment).deliver_later
    # CommentsChannel.broadcast(comment)
    redirect_to root_path
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def comments_params
    params.required(:comment).permit(:body)
  end
end
