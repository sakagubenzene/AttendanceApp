# User
User.create!(
  name: "test1",
  employee_number: "001",
  password: "password",
  admin: true
)

(2..15).each do |n|
  User.create!(
    # 2~15
    name: "test#{n}",
    employee_number: n.to_s.rjust(3, '0'),
    password: "password",
  )
end

# Attendance
40.times do |m|
  15.times do |n|
    # 1~15, 31~45, ...,1171~1185 , user_id:1~15
    Attendance.create!(
      user_id: n + 1,
      timestamp: Time.now.beginning_of_day - (39 - m).day + n.hours + (m + 2).minutes,
      status: "begin"
    )
  end

  15.times do |n|
    # 16~30, 46~60, ..., 1186~1200 user_id:1~15
    Attendance.create!(
      user_id: n + 1,
      timestamp: Time.now.beginning_of_day - (39 - m).day + (n + 8).hours + (m + 2).minutes,
      status: "finish"
    )
  end
end

5.times do |n|
  # 1201~1205, user_id:1~5
  Attendance.create!(
    user_id: n + 1,
    timestamp: Time.now.beginning_of_day - (n + 1).hours,
    status: "modification_request",
  )
end


5.times do |n|
  # 1206~1210, user_id:4~8
  Attendance.create!(
    user_id: n + 4,
    timestamp: Time.now.beginning_of_day - (n + 8).hours,
    status: "modification_request",
  )
end

# Message
(1186..1190).each do |n|
  Message.create!(
    attendance_id: n,
    receiver_id: (n + 1) % 4 + 1,
    content: "とってもありがとう",
  )
end

(1191..1200).each do |n|
  Message.create!(
    attendance_id: n,
    receiver_id: (n + 6) % 10 + 1,
    content: "いつもありがとう",
  )
end

(1201..1205).each do |n|
  Message.create!(
    attendance_id: n,
    attendance_to_change_id: n - 30,
    receiver_id: 1,
    content: "打刻忘れ"
  )
end

(1206..1210).each do |n|
  Message.create!(
    attendance_id: n,
    attendance_to_change_id: n - 17,
    receiver_id: 1,
    content: "通信障害"
  )
end
