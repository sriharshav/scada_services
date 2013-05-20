require 'date'
require 'eventmachine'
require 'json'
require 'redis'
require 'yaml'

@redcli = Redis.new(:port => 'localhost', :port => 6379)
@current_meter = 0

def format_template(n, i)

  if (n.kind_of?(Hash))
    n.each_pair do | key, value |
      if value.kind_of?(String)
        n[key] = @redcli.get "em#{i}#{value}"
      else
        format_template(value, i)
      end
    end
  end

end

EventMachine.run do

  EventMachine.add_periodic_timer(1) do

    templates = Dir["templates/**/*.yml"]
    templates.each do |template|
      (1..6).each do |i|
        t1 = YAML::load(File.read(template))
        format_template(t1, i)
        @redcli.set "em#{i}_energy", t1.to_json
      end
    end

  end

end

@redcli.quit

