class AttendancesController < ApplicationController
  include AttendancesHelper

  def new
    @attendance = Attendance.new()
    @attendance.build_message
    @unread_messages = Message.where(receiver_id: current_user.id)
                              .where(attendance_id: previous_attendance(current_user).id..)
  end

  def create
    @attendance = current_user.attendances.build(post_params)
    if @attendance.save
      flash[:success] = "打刻しました。"
      redirect_to new_attendance_path
    else
      flash.now[:error] = "打刻に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  private

    def post_params
      params.require(:attendance).permit(:timestamp, :status, message_attributes: [:receiver_id, :content])
    end

end
