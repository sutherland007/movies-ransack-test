json.extract! movie, :id, :title, :short_desc, :genre_id, :created_at, :updated_at
json.url movie_url(movie, format: :json)
