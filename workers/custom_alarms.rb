require 'eventmachine'
require 'redis'

@redcli = Redis.new(:port => 'localhost', :port => 6379)

@data = {}
@tariff_tags = (1..6).map { |i| "em#{i}activetariff" }  

EventMachine.run do

  EventMachine.add_periodic_timer(1) do

    active_tariffs = @redcli.mget @tariff_tags

    if @data[:active_tariff]
      @data[:active_tariff].each_with_index do |t, i|
        puts "#{t} #{active_tariffs[i]}"
        if (t != active_tariffs[i])
          @redcli.publish("activeTariffNotifier", "Meter#{i+1} switched to tariff #{active_tariffs[i]}")
        end
      end
    end

    @data[:active_tariff] = active_tariffs

  end
end

@redcli.quit

