class AttendancesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @attendances = Attendance.paginate(page: params[:page])
  end

  def create
    @attendance = current_user.attendances.build(attendance_params)
    @attendance.finish_at = Time.current
    if @attendance.save
      flash[:success] = "出勤が記録されました。がんばりましょう！"
      redirect_to attendances_path
    else
      render :new
    end
  end

  private

  def correct_user
    @attendance = current_user.attendances.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @attendance.nil?
  end

  def attendance_params
    params.require(:attendance).permit(:receiver_id, :content)
  end
end
