json.extract! project, :id, :user_id, :title, :description, :success, :created_at, :updated_at
json.url project_url(project, format: :json)
