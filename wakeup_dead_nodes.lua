--[[ 
%% properties 
%% autostart 
%% globals 
--]] 

local TotalDevices = 300 --max nr of devices 

while true do 

  local timeNow = os.date('*t') 
  local day = timeNow['day'] 
  local month = timeNow['month'] 
  
  local i = 1 
  local anydead = 0 
  while i < TotalDevices do 
    --check if any dead 
    local status = fibaro:getValue(i, 'dead'); 
    local name = fibaro:getName(i); 
    local room = fibaro:getRoomNameByDeviceID(i); 
    
    if status >= "1" then 
      fibaro:debug(day.."/"..month..":"..i..' DEAD '..name..":"..room); 
      fibaro:wakeUpDeadDevice(i) 
      fibaro:sleep(5000) --check again in 5 sec 
      status = fibaro:getValue(i, 'dead'); 
      if status >= "1" then
        anydead = 1; fibaro:debug('Really Dead') 
      else
        fibaro:debug('Now OK '..name) 
      end 
    end 
    i = i + 1 
  end 
  
  if anydead == 0 then
    --fibaro:debug('Nobody is dead :-) ') 
  else 
    fibaro:call(2, 'sendEmail', 'Somebody really DEAD', '..') 
    fibaro:debug('Somebody really DEAD') 
  end 
  
  -- abort any unnecesary scenes started 
  if fibaro:countScenes() > 1 then fibaro:abort() end 
  
  fibaro:sleep(15*60000) --repeat every 15 minutes 
end
