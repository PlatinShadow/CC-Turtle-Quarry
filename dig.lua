local tArgs = {...}
if #tArgs ~= 3 then
  print("Requires length, width, height")
  return
end
 
local x = tonumber(tArgs[1]) - 1
local y = tonumber(tArgs[2])
local z = tonumber(tArgs[3])
 
if x == nil or y == nil or z == nil then
  print("Invalid dimensions")
  return
end
 
if x < 0 or y < 0 or z < 0 then
  print("Invalid (negative) dimensions")
  return
end
 
local fuel = turtle.getFuelLevel()
local roomSize = x * y * z
while fuel < roomSize do
  if not turtle.refuel(1) then
    print("Not enough fuel")
    return
  end
end
 
local direction = true
for i = 1, z do
  for j = 1, y do
    for k = 1, x do
      turtle.dig()
      turtle.forward()
    end
      if direction then
        turtle.turnRight()
        turtle.dig()
        turtle.forward()
        turtle.turnRight()
        direction = false
      else
        turtle.turnLeft()
        turtle.dig()
        turtle.forward()
        turtle.turnLeft()
        direction = true
      end
    end
  if i < z then
    turtle.digDown()
    turtle.down()
    turtle.turnRight()
    turtle.turnRight() 
  end
end