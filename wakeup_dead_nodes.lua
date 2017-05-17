--[[
%% autostart
%% properties
%% events
%% globals
--]]

  -- added fix for removed devices


local TotalDevices = 1000 --max nr of devices 

while true do 

  local timeNow = os.date('*t') 
  local day = timeNow['day'] 
  local month = timeNow['month'] 
  local d_status = "ok"
  
  local i = 1 
  local anydead = 0 
  while i < TotalDevices do 
    --check if any dead 
    local status = fibaro:getValue(i, 'dead'); 
    if status ~= nil then
      
 	if status >= "1" then
        local d_status = "dead"
        else
        local d_status = "ok"
    end
    local name = fibaro:getName(i); 
    local room = fibaro:getRoomNameByDeviceID(i); 
    -- fibaro:debug(i.." "..name.." "..room.." "..d_status);
  
    
    if status >= "1" then 
      local melding = (day.."/"..month..":"..i..' DEAD, trying to re-start '..name..":"..room);
      fibaro:debug(melding); 
      fibaro:call(448,'sendPush', melding);
      fibaro:wakeUpDeadDevice(i) 
      fibaro:sleep(50000) --check again in 50 sec 
      status = fibaro:getValue(i, 'dead'); 
      if status >= "1" then
        anydead = 1;
        local melding = (day.."/"..month..":"..i..' DEAD, re-start failed '..name..":"..room);
        fibaro:debug(melding)
        fibaro:call(448,'sendPush', melding);
      else
        local melding = (day.."/"..month..":"..i..' succeeded restart '..name..":"..room);
        fibaro:debug(melding)
        fibaro:call(448,'sendPush', melding);
      end
      else
      end
    end
    i = i + 1

  end 
  
  if anydead == 0 then
    --fibaro:debug('Nobody is dead :-) ') 
  else 
    fibaro:debug('Somebody really DEAD') 
    fibaro:call(2, "sendEmail", "Fibaro device is dead", melding); -- Mail 
  end 
  
  -- abort any unnecesary scenes started 
  if fibaro:countScenes() > 1 then fibaro:abort() end 
  
  fibaro:sleep(360*60000) --repeat every 360 minutes 
  end
