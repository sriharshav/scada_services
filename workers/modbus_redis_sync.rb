require 'rmodbus'
require 'redis'
require 'eventmachine'

include ModBus

tags = ["importl1","importl2","importl3","importtotal",
  "exportl1","exportl2","exportl3","exporttotal", 
  "netl1","netl2","netl3","nettotal","ct","vt", 
  "powerfailcounter","poweroutagetime","activetariff"] 

modbus_map = [
  [0,3,14,15,16], #EM1
  [0,3,4,7,8,11,14,15,16], #EM2
  [0,1,2,3,14,15,16], #EM3
  [0,1,2,3,4,5,6,7,8,9,10,11,14,15,16], #EM4
  [0,1,2,3,12,13,14,15,16], #EM5
  [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16], #EM6
]

rc = Redis.new()

MODBUS_HR_KEY = 'modbus_hr'
rc.sadd('meters', (1..6).map {|i| "em#{i}"})
(0..119).each { |i| rc.rpush(MODBUS_HR_KEY, 0)}

ms = ModBus::TCPServer.new(8502,1)
ms.holding_registers = [0] * 120
ms.start

while (true)
  data = []

  ModBus::TCPClient.connect('127.0.0.1', 8502) do |cl|
    cl.with_slave(1) do |slave|
      slave.holding_registers[0..119] = rc.lrange(MODBUS_HR_KEY, 0, 119).map { |v| v.to_i }
      res = slave.read_holding_registers 0, 120 
      res.each_with_index do |v, i|
        meter_index = (i / 20)
        tag_index = i % 20
        if (tags[tag_index] && 
            (modbus_map[meter_index].index(tag_index) != nil))
          key = "em#{(meter_index+1)}#{tags[tag_index]}"
          data.push << key << v
        end
      end #res.each_with_index
    end #cl.with_slave
  end #ModBus::TCPClient
  rc.mset data
end

ms.stop
rc.quit
