json.array!(@notes) do |note|
  json.extract! note, :id, :domain, :posted_at, :notetype
  json.url note_url(note, format: :json)
end
