get '/meters/:id/energy' do |id|
  content_type :json
  db = Redis.new()
  energy_json = db.get("em#{id}_energy")
  db.quit
  return energy_json
end 


