set(:watcher, Thread.new do
  redis = Redis.new
  Thread.current['sockets'] = []
 
  redis.subscribe 'active_tariff' do |on|
    on.message do |channel, message|
      Thread.current['sockets'].each do |s|
        s.send message
      end
    end
  end

end)
 
get '/ws' do
  if request.websocket?
    request.websocket do |ws|
      ws.onopen do
        settings.watcher['sockets'] << ws
      end
      ws.onmessage do |msg|
        redis.publish 'powerfailcounter', msg
      end
      ws.onclose do
        settings.watcher['sockets'].delete(ws)
      end
    end
  else
    halt 400, {'Content-Type' => 'text/plain'}, 'This URI is for web sockets only'
  end
end

 
