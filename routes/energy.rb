get '/meters/:id/energy' do |id|
  content_type :json
  rcli = Redis.new()
  energy_json = rcli.get("em#{id}_energy")
  rcli.quit
  return energy_json
end 

#TODO: matches /meters/energyimport also 
get '/meters/energy/?:direction?' do |direction|
  content_type :json
  rcli = Redis.new()
  meters = rcli.smembers('meters')
  argv = []
  argv.push(meters)
  #argv.push(direction)
  if (direction && (['import', 'export', 'net'].index(direction) != nil))
    argv.push(direction)
  end
  energy_sum = rcli.eval(File.read("routes/sum.lua"), :argv => argv)
  rcli.quit
  return energy_sum
end 


