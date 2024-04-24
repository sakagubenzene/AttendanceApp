module AttendancesHelper
  def previous_attendance(user)
    user.attendances.where(status: 'begin').last
  end

  def previous_status(user)
    last_attendance = user.attendances.where(status: ['begin', 'finish']).last
    last_attendance&.status
  end
end