require 'rest-client'
require 'json'


def get_url(url)
  RestClient.get(url){|response, request, result|
    return {code: response.code, response: response, result: result}
  }
end
def symbolize_keys(obj)
  case obj
  when Array
    obj.inject([]){|res, val|
      res << case val
      when Hash, Array
        symbolize_keys(val)
      else
        val
      end
      res
    }
  when Hash
    obj.inject({}){|res, (key, val)|
      nkey = case key
      when String
        key.to_sym
      else
        key
      end
      nval = case val
      when Hash, Array
        symbolize_keys(val)
      else
        val
      end
      res[nkey] = nval
      res
    }
  else
    obj
  end
end

puts "Starting Gemworker at #{Time.now}"
puts params.class.to_s 
puts params[:repositories].inspect

repositories =params[:repositories]
processed = []
repositories.each do |repository|
  gemfile = get_url(repository[:gemfile_url])
  if gemfile[:code] < 400
    if gemfile[:response].valid_encoding?
      puts 'found!'
      repository[:gemfile_contents] = gemfile[:response]
      repository[:has_gemfile] = true
    else
      puts 'bad encoding'
      repository[:has_gemfile] = false
    end

  elsif gemfile[:code] == 404
    repository[:has_gemfile] = false
    puts 'nope'
  else

    puts "#{gemfile[:code].to_s}" +"!!!!!"
  end
  repository[:last_checked] = Time.now
  processed.push repository
end

RestClient.post("/gemfiles/update_multiple",{repositories: processed.to_json })