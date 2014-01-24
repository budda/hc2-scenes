--[[
%% properties
%% globals
--]]

local i = 1;
local TotalDevices = 40 + 1;
local errors = 0
local text = 'Some problems with device ;'

while i < TotalDevices do
  local status = fibaro:getValue(i, 'dead');
  
  if status == "1" then
    errors = errors + 1
    local desc = fibaro:getValue(i, "userDescription");
    local name = fibaro:getName(i);
    text = text ..  "\r "..name.."    ["..i.."] "..desc.." "
    fibaro:debug("Some problems with device "..name.." ["..i.."] "..desc.." Please check!"); 
  else end
  
  i = i + 1
end
text = text ..  "\r".. "Please check!"
if errors >= 1 then
 fibaro:call(2, "sendEmail", "Dead node report from Home Centre 2", text);
end  
