---https://gist.github.com/walterlua/978150
table.indexOf = function( t, object )
	local result
 
	if "table" == type( t ) then
		for i=1,#t do
			if object == t[i] then
				result = i
				break
			end
		end
	end
 
	return result
end
---

local import_sum = 0
local export_sum = 0
local net_sum = 0

local result = {}
local directions = {'import', 'export', 'net'}
local direction = ARGV[table.getn(ARGV)]

if (table.indexOf(directions, direction) == nil) then
  direction = nil
end

for var, val in pairs(ARGV) do
  if (direction) then
    --- use import_sum as temporary variable for all
    import_sum = import_sum + (redis.call("GET", val .. direction .. "total") or 0)
  else
    import_sum = import_sum + (redis.call("GET", val .. "importtotal") or 0)
    export_sum = export_sum + (redis.call("GET", val .. "exporttotal") or 0)
    net_sum = net_sum + (redis.call("GET", val .. "nettotal") or 0)
  end
end

if (direction) then
  result[direction .. 'total']= import_sum;
else
  result['importtotal']= import_sum;
  result['exporttotal']= export_sum;
  result['nettotal']= net_sum;
end

return cjson.encode(result)

