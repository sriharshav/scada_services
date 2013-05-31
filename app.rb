#Sinatra application

require 'bundler/setup'
Bundler.require(:default)

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
# Resource routes
#---------------------------
require_relative "routes/web_socket_channel.rb"
require_relative "routes/energy.rb"
require_relative "routes/modbus_map.rb"
#require_relative "routes/ratios.rb"

