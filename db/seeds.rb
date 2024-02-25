50.times do |i|
  task_id = i + 1
  Task.create!(title: "test#{task_id}", content: "task#{task_id}")
end
