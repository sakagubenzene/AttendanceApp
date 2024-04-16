# ユーザーデータの生成
user1 = User.create!(
  name: "John Doe",
  employee_number: "001",
  password: "password",
  admin: true
)

user2 = User.create!(
  name: "Jane Smith",
  employee_number: "002",
  password: "password",
  admin: false
)

# 出退勤データの生成
Attendance.create!(
  user_id: user1.id,
  begin_at: Time.now.beginning_of_day + 8.hours, # 今日の8時
  finish_at: Time.now.beginning_of_day + 17.hours # 今日の17時
)

Attendance.create!(
  user_id: user2.id,
  begin_at: Time.now.beginning_of_day + 9.hours, # 今日の9時
  finish_at: Time.now.beginning_of_day + 18.hours # 今日の18時
)

# メッセージデータの生成
Message.create!(
  sender_id: user1.id,
  receiver_id: user2.id,
  content: "とってもありがとう"
)

Message.create!(
  sender_id: user2.id,
  receiver_id: user1.id,
  content: "いつもありがとう"
)
