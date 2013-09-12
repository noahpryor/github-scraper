json.array!(@gemfiles) do |gemfile|
  json.extract! gemfile, :repository_id, :url, :contents, :last_checked
  json.url gemfile_url(gemfile, format: :json)
end
