User.create!(
  name: 'taro',
  email: 'taro@sample.com',
  password: 'password',
  admin: true
)
User.create!(
  name: 'jiro',
  email: 'jiro@sample.com',
  password: 'drowssap',
  admin: false
)

50.times do |i|
  task_id = i + 1
  month = rand(1..12)
  if month == 2
    day = rand(1..28)
  else
    day = rand(1..30)
  end
  task_deadline_on = "2022-#{month}-#{day}"
  task_priority = rand(0..2)
  task_status = rand(0..2)
  Task.create!(
    title: "taro's test#{task_id}",
    content: "taro's task#{task_id}",
    deadline_on: task_deadline_on,
    priority: task_priority,
    status: task_status,
    user_id: User.all[0].id
  )
end
50.times do |i|
  task_id = i + 51
  month = rand(1..12)
  if month == 2
    day = rand(1..28)
  else
    day = rand(1..30)
  end
  task_deadline_on = "2022-#{month}-#{day}"
  task_priority = rand(0..2)
  task_status = rand(0..2)
  Task.create!(
    title: "jiro's test#{task_id}",
    content: "jiro's task#{task_id}",
    deadline_on: task_deadline_on,
    priority: task_priority,
    status: task_status,
    user_id: User.all[1].id
  )
end
