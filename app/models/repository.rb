# == Schema Information
#
# Table name: repositories
#
#  id                 :integer          not null, primary key
#  repository_url     :text
#  last_created       :datetime
#  owner_name         :text
#  first_created      :datetime
#  repo_size          :integer
#  repository_created :datetime
#  watchers           :integer
#  forks              :text
#  last_push          :text
#  feed_hits          :integer
#  has_gemfile        :boolean
#  gemfile_contents   :text
#  last_checked       :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class Repository < ActiveRecord::Base
  # validates :repository_url, uniqueness: true



  def raw_url
    url.gsub("github.com","raw.github.com") if url.include? "github.com"
  end
  def url
    repository_url
  end

  def repository_stub
    url.split(".com/")[1]
  end
  def name
    repository_stub.split("/")[1]
  end

  def owner
    repository_stub.split("/")[0]
  end


  def ironworker_format
    {
      id: id,
      gemfile_url: gemfile_url
    }
  end


  def self.queue_iron_worker_tasks(worker_name="github")
    where(last_checked: nil).find_in_batches(batch_size: 50) do |batch|
      repositories = batch.collect {|r| r.ironworker_format }
      client = IronWorkerNG::Client.new
      client.tasks.create(worker_name,"repositories"=> repositories)
    end
  end

  def self.get_gemfiles(older_than=2.years.ago.to_date)
    where("(has_gemfile = true or has_gemfile is null) and (last_checked is null or last_checked > ?)",
    older_than).find_each do |repository|
      repository.update_gemfile
    end
  end

  def update_gemfile
    gemfile = get_gemfile
    if gemfile[:code] == 200
      puts 'found!'
      self.gemfile_contents = gemfile[:response]
      self.has_gemfile = true
    elsif gemfile[:code] == 404
      self.has_gemfile = false
      puts 'nope'
    elsif gemfile[:code] == 403

      raise Forbidden
    else
      self.has_gemfile = false
      puts 'nope'+gemfile[:code].to_s
    end
    self.last_checked = Time.now
    self.save
  end

  def get_gemfile
    get_url(gemfile_url)
  end

  def get_url(url)
    RestClient.get(url){|response, request, result|
      return {code: response.code, response: response, result: result}
    }




  end

  def gemfile_url
    raw_url+"/master/Gemfile"
  end

  def gemspec_url
    raw_url+"/master/gemspec"
  end

end
