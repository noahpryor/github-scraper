require 'csv'
desc "Load github data"
task :load_github_data => :environment do
  def percent(numerator,denominator)
    #ghetto progressbar
      decimal = (numerator.to_f/denominator.to_f)
    if decimal == decimal.round(4)
      string = (decimal*100).round(2).to_s+"%"
      puts string 
    end
  end

  repositories = []
  total = 200453
  i = 0
  puts 'starting load'
  commits = CSV.read("ruby_commits_two.csv", :headers => true) 
  puts 'finished'
  commits.each do |row|
   print i.to_s+"|"
    begin
      repository_data = row.to_hash
      begin
        repository_data["last_created"] = DateTime.parse(row["last_created"])
      rescue
        repository_data.delete("last_created")
      end

      begin
        repository_data["last_push"] = DateTime.parse(row["last_push"])
      rescue
        repository_data.delete("last_push")
      end

      begin
        repository_data["repository_created"] = DateTime.parse(row["repository_created"])
      rescue
        repository_data.delete("repository_created")
      end

      begin
        repository_data["first_created"] = DateTime.parse(row["first_created"])
      rescue
        repository_data.delete("first_created")
      end


      repositories.push( Repository.new(repository_data))
      i = i + 1
      if repositories.size == 1000
        print i.to_s 
        puts ""
        puts "import"
        Repository.import repositories
        repositories = []
      end
      #puts repository.id.to_s
    rescue =>e
        puts e.inspect

    end
  end
    Repository.import repositories

end
