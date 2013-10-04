--[[
%% autostart
%% properties
%% globals
--]]

local light = 10;

while true do
  if (tonumber(fibaro:getValue(light, "value")) == 99)
  then
    fibaro:debug('preparing to turn off your lights...');
  	fibaro:sleep(1800000); --  30 minute delay before switch off
    fibaro:call(light, 'turnOff');
  end
  
  fibaro:sleep(900000); -- 15 minute delay until we check again
end
