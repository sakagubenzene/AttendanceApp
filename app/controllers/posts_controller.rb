class PostsController < ApplicationController

  def new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
    else
      redirect_to new_user_path
    end
    redirect_to new_post_path
  end

  private

  def post_params
    params.require(:post).permit(:description, attendance_attributes: [:begin_at, :finish_at], message_attributes: [:receiver_id, :content])
  end
end
