json.array!(@djs) do |dj|
  json.extract! dj, :id, :artist_name
  json.url dj_url(dj, format: :json)
end
