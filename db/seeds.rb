# User
User.create!(
  name: "test1",
  employee_number: "001",
  password: "password",
  admin: true
)

(2..15) each do |n|
  User.create!(
    name: "test#{n}",
    employee_number: n.to_s.rjust(3, '0'),
    password: "password",
  )
end

# Attendance
15.times do |n|
  Attendance.create!(
    user_id: n + 1,
    timestamp: Time.now.beginning_of_day + n.hours,
    status: "begin"
  )

  Attendance.create!(
    user_id: n + 1,
    timestamp: Time.now.beginning_of_day + (n + 8).hours,
    status: "finish"
  )
end

5.times do |n|
  Attendance.create!(
    user_id: n + 1,
    timestamp: Time.now.beginning_of_day + (n + 1).hours,
    status: "begin_request",
    reason: "打刻忘れ"
  )

  Attendance.create!(
    user_id: n + 4,
    timestamp: Time.now.beginning_of_day + (n + 8).hours,
    status: "finish",
    reason: "通信障害"
  )
end

# Message
15.times do |n|
  Message.create!(
    sender_id: n + 1,
    receiver_id: (n + 1) % 4 + 1,
    attendance_id: 
    content: "とってもありがとう",
  )
end

5.times do |n|
  Message.create!(
    sender_id: n + 1,
    receiver_id: n + 6,
    content: "いつもありがとう",
  )
end
  