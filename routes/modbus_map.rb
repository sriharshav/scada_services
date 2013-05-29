get '/modbus/holdingregisters' do
  content_type :json
  rcli = Redis.new()
  modbusmap = rcli.lrange("modbus_hr", 0, 119)
  rcli.quit
  return modbusmap.to_json
end

post '/modbus/holdingregisters' do
  content_type :json
  request.body.rewind
  data = JSON.parse(request.body.read)

  rcli = Redis.new()

  result = rcli.pipelined do
    data.each do |key, value|
      modbus_address = key.to_i
      if ((modbus_address >= 0) && (modbus_address < 120))
        rcli.lset("modbus_hr", modbus_address, value.to_i)
      end
    end
  end

  rcli.quit
  return result.to_json
end

