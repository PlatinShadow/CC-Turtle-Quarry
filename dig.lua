function makeHole(x, y , z)
  local dir = vector.new(direction.x, direction.y , direction.z)
  for i = 1, (z + 1) do
    for j = 1, y do
      for k = 1, x do
        turtle.dig()
        turtle.forward()
      end
      if j < y then
        if (dir.x == direction.x and dir.z == direction.z) then
          turtle.turnRight()
          turtle.dig()
          turtle.forward()
          turtle.turnRight()
          rotateOpposite()
        else
          turtle.turnLeft()
          turtle.dig()
          turtle.forward()
          turtle.turnLeft()
          rotateOpposite()
        end
      end
    end
    if i <= z then
      turtle.digDown()
      turtle.down()
      turtle.turnRight()
      turtle.turnRight()
    end
  end 
end

function ItemCount()

end
-- east = (1,0)
-- west = (-1,0)
-- north = (0,-1)
-- south = (0,1)
function getDirection()
  local pos1 = vector.new(gps.locate(5))
  turtle.forward()
  local pos2 = vector.new(gps.locate(5))

  local diff = pos2 - pos1
  diff.y = 0

  print("pos1: ", tostring(pos1))
  print("pos2: ", tostring(pos2))
  print("diff: ", tostring(diff))


  return diff
end

function rotateRight()
  if(direction.x == 0 and direction.z == -1) then -- north to east
    direction.x = 1
    direction.z = 0 
  elseif(direction.x == 1 and direction.z == 0) then  -- east to south
    direction.x = 0
    direction.z = 1
  elseif(direction.x == 0 and direction.z == 1) then  -- south to west
    direction.x = -1
    direction.z = 0  
  elseif (direction.x == -1 and direction.z == 0) then -- west to north
    direction.x = 0
    direction.z = -1
  end
end

function rotateLeft()
  if(direction.x == 0 and direction.z == -1) then -- north to west
    direction.x = -1
    direction.z = 0 
  elseif(direction.x == 0 and direction.z == -1) then  -- west to south
    direction.x = 0
    direction.z = 1
  elseif(direction.x == 0 and direction.z == 1) then  -- south to east
    direction.x = 1
    direction.z = 0  
  elseif (direction.x == 1 and direction.z == 0) then -- east to north
    direction.x = 0
    direction.z = -1
  end
end

function rotateOpposite()
  if(direction.x == 0 and direction.z == -1) then -- north to south
    direction.x = 0
    direction.z = 1 
  elseif(direction.x == 0 and direction.z == 1) then  -- south to north
    direction.x = 0
    direction.z = -1
  elseif(direction.x == 1 and direction.z == 0) then  -- east to west
    direction.x = -1
    direction.z = 0  
  elseif (direction.x == -1 and direction.z == 0) then -- west to east
    direction.x = 1
    direction.z = 0
  end
end

function printDirection(dir)
  local s
  if(dir.x == 1) then s = "east" end
  if(dir.x == -1) then s = "west" end
  if(dir.z == 1) then s = "south" end
  if(dir.z == -1) then s = "north" end

  print(s)
end




local tArgs = {...}
if #tArgs ~= 3 then
  print("Requires length, width, height")
  return
end
 
direction = nil
direction = getDirection()
printDirection(direction)

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
  fuel = turtle.getFuelLevel()
end


makeHole(x, y, z)