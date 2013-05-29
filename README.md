scada_services
==============

Scada services with redis and web sockets

###Introduction###
Scada Services is an experimental setup to host SCADA webservices backed with redis store and with support of web sockets.

###Installation###

- ####Install ruby###

  Install ruby 2.0 and make it available in folder accessible from PATH.
  
  *Windows steps*

  - Download [ruby installer](http://rubyinstaller.org/downloads/)
  - *Select to add ruby to path*
  - *Prefer default installation path C:\Ruby200*    

- ####Install ruby gems [bundler](https://rubygems.org/gems/bundler) and [foreman](https://rubygems.org/gems/foreman)####

		 gem install bundler
		 gem install foreman

   *Note for Windows* Prefer version 0.61.0

         gem install foreman -v 0.61.0
	
- ####Compile/Download redis-server####
 
  Download 2.6.x version, compile and place it in folder accessible from system PATH environment

  *Windows steps*
 
  Download release version of redis-server from [MSOpenTech / redis](https://github.com/MSOpenTech/redis/tree/2.6/bin/release)

- ####Clone source####

	Clone repo
	
		 git clone https://github.com/sriharshav/scada_services.git
	
- ####Install ruby gems in Gemfile####
    
		 bundle install --path vendor/bundle

###Starting server###

Execute following command from source directory

	 foreman start

*Wait till sinatra service is up and running*

###Test REST API###

*Note for Windows* :  curl comes default with msys git.

1. Get energy of meter1

		 curl http://localhost/meters/1/energy

2. Get import, export and net totals of all meters

		 curl http://localhost/meters/energy

3. Get import of all meters

		 curl http://localhost/meters/energy/import

###Modbus mapping###

Assumed modbus mapping is in doc/modbus\_mapping.txt

----

**For more information please refer to [wiki](https://github.com/sriharshav/scada_services/wiki)**

