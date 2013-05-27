get '/meters/:id/energy' do |id|
  content_type :json
  rcli = Redis.new()
  energy_json = rcli.get("em#{id}_energy")
  rcli.quit
  return energy_json
end 

get '/meters/energy' do
  content_type :json
  rcli = Redis.new()
  meters = rcli.smembers('meters')
  energy_sum = rcli.eval(File.read("templates/sum.lua"), :args => meters)
  rcli.quit
  return {:sum => energy_sum}.to_json
end 


