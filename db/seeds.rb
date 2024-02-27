Task.create!(
  title: "first_task",
  content: "submit document",
  deadline_on: "2022-02-18",
  priority: 1,
  status: 0
)
Task.create!(
  title: "second_task",
  content: "write Qiita issue",
  deadline_on: "2022-02-17",
  priority: 2,
  status: 1
)
Task.create!(
  title: "third_task",
  content: "purchase milk",
  deadline_on: "2022-02-16",
  priority: 0,
  status: 2
)

20.times do |i|
  task_id = i + 4
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
    title: "test#{task_id}",
    content: "task#{task_id}",
    deadline_on: task_deadline_on,
    priority: task_priority,
    status: task_status
  )
end
