--[[ 
%% properties 
%% globals 
--]] 

local i = 1;
local TotalDevices = 40 + 1;

while i < TotalDevices do 
  local status = fibaro:getValue(i, 'dead'); 

  if status == "1" then 
    local desc = fibaro:getValue(i, "userDescription");
    local name = fibaro:getName(i);
    fibaro:debug("Some problems with device "..name.." ["..i.."] "..desc.." Please check!"); 
    fibaro:call(2, "sendEmail", "Dead node report from Home Centre 2", "Some problems with device "..name.." ["..i.."] "..desc); 
  else end
  
  i = i + 1 
end
