require 'csv'
desc "Load github data"
task :get_gemfiles => :environment do
  Repository.where("gemfile_contents is null and has_gemfile is null and last_checked is null").order("id asc").find_each do |repository|
      gemfile = repository.get_gemfile 
    if gemfile[:code] < 400
      if gemfile[:response].valid_encoding?
      puts 'found!'
      repository.gemfile_contents = gemfile[:response]   
      repository.has_gemfile = true   
      else 
        puts 'bad encoding'
        repository.has_gemfile = false
      end

    elsif gemfile[:code] == 404
      repository.has_gemfile = false
      puts 'nope'
    else

      puts "#{gemfile[:code].to_s}" +"!!!!!"
    end
    repository.last_checked = Time.now
    repository.save
  end

end
