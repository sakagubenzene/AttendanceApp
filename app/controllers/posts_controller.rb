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
      flash[:success] = "打刻しました。"
      redirect_to new_post_path
    else
      flash.now[:error] = "メッセージを送る社員名を選んでください。"
      render :new, status: :unprocessable_entity
    end
  end

  def update

  end

  private

  def post_params
    params.require(:post).permit(attendance_attributes: [:begin_at, :finish_at, :user_id], message_attributes: [:sender_id, :receiver_id, :content, :read])
  end
end
