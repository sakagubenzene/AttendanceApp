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

# Post データの生成と出退勤、メッセージデータの関連付け
post1 = user1.posts.create!
post2 = user2.posts.create!

Attendance.create!(
  post_id: post1.id,
  user_id: user1.id,
  begin_at: Time.now.beginning_of_day + 8.hours, # 今日の8時
  finish_at: Time.now.beginning_of_day + 17.hours # 今日の17時
)

Attendance.create!(
  post_id: post2.id,
  user_id: user2.id,
  begin_at: Time.now.beginning_of_day + 9.hours, # 今日の9時
  finish_at: Time.now.beginning_of_day + 18.hours # 今日の18時
)

Message.create!(
  post_id: post1.id,
  sender_id: user1.id,
  receiver_id: user2.id,
  content: "とってもありがとう",
  read: false
)

Message.create!(
  post_id: post2.id,
  sender_id: user2.id,
  receiver_id: user1.id,
  content: "いつもありがとう",
  read: false
)
