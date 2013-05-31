#Sinatra application

require 'bundler/setup'
Bundler.require(:default)

set(:watcher, Thread.new do
  redis = Redis.new
  Thread.current['sockets'] = []
 
  redis.subscribe 'activeTariffNotifier' do |on|
    on.message do |channel, message|
      Thread.current['sockets'].each do |s|
        s.send message
      end
    end
  end

end)

#---------------------------
#Configuration
#---------------------------
set :port, 80 
set :haml, {:format => :html5 }

#---------------------------
# Static Routes
#---------------------------
get '/' do 
  haml :index
end 

get '/:filename.htm' do |filename|
  content_type 'text/html', :charset => 'utf-8'
  render :haml, filename.to_sym, :layout => false, :views => './views'
end

get '/css/:filename.css' do |filename|
  content_type 'text/css', :charset => 'utf-8'
  render :scss, filename.to_sym, :layout => false, :views => './public/css'
end

#---------------------------
# Web socket
#---------------------------
get '/ws' do
  if !request.websocket?
    erb :index
  else
    request.websocket do |ws|
      ws.onopen do
        ws.send("Web socket connection established with server.")
        settings.watcher['sockets'] << ws
      end
      ws.onmessage do |msg|
        puts msg
      end
      ws.onclose do
        warn("wetbsocket closed")
        settings.watcher['sockets'].delete(ws)
      end
    end
  end
end

#---------------------------
# Resource routes
#---------------------------
require_relative "routes/energy.rb"
require_relative "routes/modbus_map.rb"
require_relative "routes/ratios.rb"

