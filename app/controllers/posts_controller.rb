class PostsController < ApplicationController

  def new
  end

  def create
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:success] = "Welcome to the Sample App!"
    else
      flash[:danger] = "だめ！"
    end
    redirect_to new_post_path
  end

  private

  def post_params
    params.require(:post).permit(:description, attendance_attributes: [:begin_at, :finish_at], message_attributes: [:receiver_id, :content])
  end
end
