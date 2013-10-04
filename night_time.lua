--[[ 
%% autostart 
%% properties 
%% globals 
--]] 

while true do 
  
  local currentDate = os.date("*t"); 
  local sunriseHour = fibaro:getValue(1, 'sunriseHour'); 
  local sunsetHour = fibaro:getValue(1, 'sunsetHour'); 
  
  local currentSec = tonumber(currentDate.hour) * 60 + tonumber(currentDate.min); 
  local sunriseSec = tonumber(string.sub(sunriseHour, 1, 2)) * 60 + tonumber(string.sub(sunriseHour, 4)); 
  local sunsetSec = tonumber(string.sub(sunsetHour, 1, 2)) * 60 + tonumber(string.sub(sunsetHour, 4)); 

  if (currentSec>sunriseSec and currentSec<sunsetSec) then 
    fibaro:setGlobal("NightTime", "0"); 
  else 
    fibaro:setGlobal("NightTime", "1"); 
  end 

  fibaro:debug('Now: ' .. currentSec .. '; Sunrise: ' .. sunriseSec .. '; Sunset: ' .. sunsetSec .. '; Night: ' .. fibaro:getGlobal("NightTime") .. ';'); 

  fibaro:sleep(60000*10); 
  
end
