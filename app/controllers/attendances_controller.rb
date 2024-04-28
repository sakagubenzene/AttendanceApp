class AttendancesController < ApplicationController
  include AttendancesHelper
  before_action :logged_in_user
  before_action :admin_user, only: [:index, :destroy]
  
  def new
    @attendance = Attendance.new()
    @attendance.build_message
    @unread_messages = Message.where(receiver_id: current_user.id)
                              .where(attendance_id: previous_attendance(current_user)&.id..)
  end

  def index
    @attendances = Attendance.where(status:"modification_request").all.includes(user: :messages)
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
    @attendance = Attendance.find(params[:id])
    ActiveRecord::Base.transaction do
      # 変更対象のAttendance情報を取得
      attendance_to_change = @attendance.message.attendance_to_change
      
      # 変更対象のAttendanceのtimestampを現在のAttendanceのtimestampに更新
      attendance_to_change.update!(timestamp: @attendance.timestamp)
      
      # 修正依頼statusを"settled"に更新
      @attendance.update!(status: "settled")
      
      # 修正依頼のattendance_to_change_idをnilに更新
      @attendance.message.update!(attendance_to_change_id: nil)
    end

    redirect_to attendances_path, notice: "正常に修正しました。"
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to attendances_path
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.update!(status: "unsettled")
    redirect_to attendances_path, notice: "正常に不許可登録が完了しました。"
    rescue ActiveRecord::RecordInvalid => e
      flash[:error]
      redirect_to attendances_path
  end

  def show
    attendance = Attendance.find(params[:id])
  end

  def previous_timestamp
    attendance = Attendance.find(params[:id]).timestamp
  end
  
  private

    def post_params
      params.require(:attendance).permit(:timestamp, :status, message_attributes: [:receiver_id, :content, :attendance_to_change_id])
    end

    #before_action
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url, status: :see_other
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user&.admin?
    end

end
