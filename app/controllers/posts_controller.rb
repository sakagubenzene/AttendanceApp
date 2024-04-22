class PostsController < ApplicationController
  before_action :set_user, only: [:update]

  def new
    @post = Post.find_or_initialize_by(iser)
    @post.build_message
    @unread_messages = Message.where(receiver_id: current_user.id, read: false)
  end

  def create
    @post = current_user.posts.build(post_params)
    if current_user.is_attending
      handle_finish_attendance
    else
      handle_begin_attendance
    end
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

    def post_params_for_begin
      params.require(:post).permit(attendance_attributes: [:begin_at, :user_id], message_attributes: [:sender_id, :receiver_id, :content, :read])
    end

    def post_params_for_finish
      params.require(:post).permit(attendance_attributes: [:begin_at, :finish_at, :user_id], message_attributes: [:sender_id, :receiver_id, :content, :read])
    end

    def handle_begin_attendance
      current_user.update(is_attending: true)
      if @post.save
        flash[:success] = "出勤打刻しました。"
      else

        flash.now[:error] = "出勤打刻に失敗しました。"
        render :new, status: :unprocessable_entity
      end
    end

    def handle_finish_attendance
      @post.attendance.finish_at = Time.current
      current_user.update(is_attending: false)
      if @post.save
        flash[:success] = "退勤打刻しました。"
        redirect_to new_post_path
      else
        flash.now[:error] = "退勤打刻に失敗しました。"
        render :new, status: :unprocessable_entity
      end
    end
end
