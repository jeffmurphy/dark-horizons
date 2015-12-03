json.array!(@watchers) do |watcher|
  json.extract! watcher, :id, :apiurl, :apikey, :username, :password, :domain
  json.url watcher_url(watcher, format: :json)
end
