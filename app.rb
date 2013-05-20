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


#---------------------------
# Resource routes
#---------------------------
require_relative "routes/energy.rb"
