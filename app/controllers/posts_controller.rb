class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.build_attendance
    @post.build_message
    @unread_messages = Message.where(receiver_id: current_user.id, read: false)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to new_post_path, notice: 'Post was successfully created.'
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(attendance_attributes: [:begin_at, :finish_at, :user_id], message_attributes: [:sender_id, :receiver_id, :content, :read])
  end
end
