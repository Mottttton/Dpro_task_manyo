50.times do |i|
  unless Task.find_by(id: i+1)
    Task.create!(title: "test#{i+1}", content: "task#{i+1}")
  end
end
