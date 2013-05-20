local sum = 0
for i = 1, 5, 1 do
	sum = sum + redis.call("GET", KEYS[i])
end
return sum

