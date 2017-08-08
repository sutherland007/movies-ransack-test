json.extract! writer, :id, :first_name, :last_name, :created_at, :updated_at
json.url writer_url(writer, format: :json)
