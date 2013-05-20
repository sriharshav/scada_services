require 'rmodbus'
require 'redis'

include ModBus

tags = ["importl1","importl2","importl3","importtotal",
  "exportl1","exportl2","exportl3","exporttotal", 
  "netl1","netl2","netl3","nettotal","ct","vt", 
  "powerfailcounter","poweroutagetime","activetariff"] 

rc = Redis.new()
cl = RTUClient.new('COM8', 25600)

while (true)
  data = []
  cl.with_slave(1) do |slave|
    res = slave.read_holding_registers 0, 120 
    res.each_with_index do |v, i|
      if (tags[i % 20])
        key = "em#{((i / 20)+1)}#{tags[i % 20]}"
        data.push << key << v
      end
    end
    slave.holding_registers[0..119] = res.map { |x| x + 1 } 
  end
  rc.mset data
end

cl.close
rc.quit

