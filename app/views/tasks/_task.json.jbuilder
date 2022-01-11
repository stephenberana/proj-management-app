json.extract! task, :id, :name, :starting_date, :completion_date, :status, :priority, :project_id, :artifact_id, :created_at, :updated_at
json.url task_url(task, format: :json)
