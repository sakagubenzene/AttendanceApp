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
15.times do |n|
  # 1~15, user_id:1~15
  Attendance.create!(
    user_id: n + 1,
    timestamp: Time.now.beginning_of_day + n.hours,
    status: "begin"
  )
end

15.times do |n|
  # 16~30, user_id:1~15
  Attendance.create!(
    user_id: n + 1,
    timestamp: Time.now.beginning_of_day + (n + 8).hours,
    status: "finish"
  )
end

5.times do |n|
  # 31~35, user_id:1~5
  Attendance.create!(
    user_id: n + 1,
    timestamp: Time.now.beginning_of_day - (n + 1).hours,
    status: "modification_request",
  )
end


5.times do |n|
  # 36~40
  Attendance.create!(
    user_id: n + 4,
    timestamp: Time.now.beginning_of_day - (n + 8).hours,
    status: "modification_request",
  )
end

# Message
(16..20).each do |n|
  Message.create!(
    attendance_id: n,
    receiver_id: (n + 1) % 4 + 1,
    content: "とってもありがとう",
  )
end

(21..30).each do |n|
  Message.create!(
    attendance_id: n,
    receiver_id: (n + 6) % 10 + 1,
    content: "いつもありがとう",
  )
end

(31..35).each do |n|
  Message.create!(
    attendance_id: n,
    attendance_to_change_id: n - 30,
    receiver_id: 1,
    content: "打刻忘れ"
  )
end

(36..40).each do |n|
  Message.create!(
    attendance_id: n,
    attendance_to_change_id: n - 17,
    receiver_id: 1,
    content: "通信障害"
  )
end
