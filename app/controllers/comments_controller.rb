class CommentsController < ApplicationController
  before_action :set_post

  def create
    @post.comments.create! comments_params
    # CommentsMailer.submitted(comment).deliver_later
    # CommentsChannel.broadcast(comment)
    flash[:success] = 'Comentario feito com sucesso.'
    redirect_to root_path
  rescue
    redirect_to comments_path, alert: "Preencha todos os campos."
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def comments_params
    params.required(:comment).permit(:body)
  end
end
