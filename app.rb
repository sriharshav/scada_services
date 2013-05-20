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
get '/home.htm' do
  haml :home
end 

#---------------------------
# Templates
#---------------------------
get '/css/consolidated.css' do
  content_type 'text/css', :charset => 'utf-8'
  filename = "consolidated"
  render :scss, filename.to_sym, :layout => false, :views => './public/css'
end

#---------------------------
# Resource routes
#---------------------------
require_relative "routes/energy.rb"
