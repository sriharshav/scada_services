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

	Open command prompt and execute
	  
		 gem install bundler
	
	######Offline installation######
	
	*When working behing corporte firewalls, try offline installation*
	
	1. Download [bundler gem](https://rubygems.org/gems/bundler)
	2. Open command prompt
	3. Change to directory where gem is downloaded
	4. Execute
	
			gem install bundler-1.3.5.gem

- ###Install [foreman gem 0.61.0](https://rubygems.org/gems/foreman/versions/0.61.0)###
	
	Open command prompt and execute
	  
	      gem install foreman -v 0.61.0
	
- ###Clone source###

	Clone from
	
		git clone https://github.com/sriharshav/scada_services.git
	
##System setup and dependencies##

- Install ruby gems with 
    
    bundle install --path vendor/bundle

- Create virtual port pair COM7-COM8 using Null-modem emulator
-	Download Free version of Modbus slave simulator from mobusdriver.com and place it in tools folder
- Download release version of redis-server from MSOpenTech / redis  and place it in tools folder

##Starting app##

1. Open command prompt
2. Change to directory where source is cloned
3. Execute

      	foreman start


----

**For more information please refer to [wiki](https://github.com/sriharshav/scada_services/wiki)**

