json.array!(@repositories) do |repository|
  json.extract! repository, :repository_url, :last_created, :owner_name, :first_created, :repo_size, :repository_created, :watchers, :forks, :last_push, :feed_hits, :has_gemfile, :gemfile_contents, :last_checked
  json.url repository_url(repository, format: :json)
end
