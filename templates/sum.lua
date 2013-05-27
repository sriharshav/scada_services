local import_sum = 0
local export_sum = 0
local net_sum = 0

local result = {}

for var, val in pairs(ARGV) do
	import_sum = import_sum + (redis.call("GET", val .. "importtotal") or 0)
	export_sum = export_sum + (redis.call("GET", val .. "exporttotal") or 0)
	net_sum = net_sum + (redis.call("GET", val .. "nettotal") or 0)
end
result['importtotal']= import_sum;
result['exporttotal']= export_sum;
result['nettotal']= net_sum;
return cjson.encode(result)

