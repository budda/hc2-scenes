--[[ 
%% autostart 
%% properties 
%% globals 
--]] 

while true do 

local currentDate = os.date("*t"); 
local wakeuptime = "07:45"; -- time to wake up 
local startlevel = 20; -- start dim level 
local dimlevel; 
local maxlevel = 100; -- max dim level 
local diminterval = 1; -- interval time in minutes to wait to next dimlevel 
local levelsteps = 10; -- steps in procent to increase dim level 
local light = 26; -- light to control 
local debug = true; 

if (maxlevel > 100) then maxlevel = 100; end 
if (startlevel > maxlevel) then startlevel = maxlevel; end 
  
if ( ( ((currentDate.wday == 1 or currentDate.wday == 2 or currentDate.wday == 3 or currentDate.wday == 4 or currentDate.wday == 5 or currentDate.wday == 6 or currentDate.wday == 7) and string.format("%02d", currentDate.hour) .. ":" .. string.format("%02d", currentDate.min) == wakeuptime) ) ) 
then 
  fibaro:debug("Wake up started at: " .. os.date()); 
  for level = startlevel, maxlevel, levelsteps do 
    dimlevel = level; 
    if (dimlevel > 100) then dimlevel = 100; end 
    fibaro:call(light, "setValue", dimlevel); 
    if (debug) then fibaro:debug("Set dim level at: " .. os.date()); end 
    if (debug) then fibaro:debug("Dimlevel: " .. dimlevel); end 
    fibaro:sleep(diminterval*60*1000); 
  end 
end 

fibaro:sleep(60*1000); 
end 
