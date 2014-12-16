json.array!(@tracks) do |track|
  json.extract! track, :id, :title, :dj_id, :duration
  json.url track_url(track, format: :json)
end
