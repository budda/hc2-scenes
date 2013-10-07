--[[ 
%% properties 
%% globals 
--]] 

-- convert MAC adress, every 2 Chars (7-bit ASCII), to one Byte Char (8-bits) 
function convertMacAddress(address) 
  local s = string.gsub(address, ":", ""); 
  local x = "";  -- will contain converted MAC 
  for i=1, 12, 2 do 
    x = x .. string.char(tonumber(string.sub(s, i, i+1), 16)); 
  end 
  return x; 
end 

fibaro:log("Start process"); 

-- MAC adress 
local _macAddress = convertMacAddress("xx:xx:xx:xx:xx:xx"); 
-- Create Magic Packet 6 x FF 
local _magicPacket = string.char(0xff, 0xff, 0xff, 0xff, 0xff, 0xff); 
-- Broadcast Address 
local _broadcastAddress = "255.255.255.255"; 
-- Default port used 
local _wakeOnLanPort = 9; 

fibaro:sleep(750); 

for i = 1, 16 do 
  _magicPacket = _magicPacket .. _macAddress; 
end 

fibaro:log("Magic packet successfully created"); 

fibaro:sleep(1000); 

socket = Net.FUdpSocket(); 
socket:setBroadcast(true); 

local bytes, errorCode = socket:write(_magicPacket, _broadcastAddress, _wakeOnLanPort); 
--check for error      
if errorCode == 0 then 
  fibaro:log("Successfully sent"); 
else 
  fibaro:log("Transfer failed"); 
end 

-- clean up memory 
socket = nil; 

fibaro:sleep(1000); 
fibaro:log("Please wait for the server startup.");
