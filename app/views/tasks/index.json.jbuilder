json.array!(@tasks) do |task|
  json.extract! task, :title, :due
  json.url task_url(task, format: :json)
end
