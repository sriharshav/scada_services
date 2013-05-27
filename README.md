scada_services
==============

Scada services with redis and web sockets

##Introduction##
Scada Services is an experimental setup to host SCADA webservices backed with redis store and with support of web sockets.

##Installation (Windows 7 and above)##

- ###Install [ruby](http://rubyinstaller.org/downloads/)###

	- *Prefer Ruby 2.0.0-p0*
	- *Select to add ruby to path*
	- *Prefer default installation path C:\Ruby200*    

- ###Install [bundler gem](https://rubygems.org/gems/bundler)###

		 gem install bundler
	
- ###Install [foreman gem 0.61.0](https://rubygems.org/gems/foreman/versions/0.61.0)###
	
		 gem install foreman -v 0.61.0
	
- ###Clone source###

	Clone repo
	
		 git clone https://github.com/sriharshav/scada_services.git
	
##System setup and dependencies##

- Install ruby gems in Gemfile with 
    
		 bundle install --path vendor/bundle

- Create virtual port pair COM7-COM8 using [Null-modem emulator](http://com0com.sourceforge.net/)
-	Download Free version of Modbus slave simulator from [mobusdriver.com](http://mobusdriver.com) and place it in tools folder
- Download release version of redis-server from [MSOpenTech / redis](https://github.com/MSOpenTech/redis/tree/2.6/bin/release)  and place it in tools folder

##Starting server##

Execute following command from source directory

	 foreman start

*Wait till sinatra service is up and running*

##Test REST API##

*curl comes default with msys git.*

1. Getting energy of meter1

		 curl http://localhost/meters/1/energy

----

**For more information please refer to [wiki](https://github.com/sriharshav/scada_services/wiki)**

