--[[ 
%% properties 

%% globals 
--]] 

fibaro:debug('start') 

fibaro:call(11, 'sendPush', "Lights simulation started") 

local minute = 60000 --in miliseconds 

local rndmaxtime = 10  --random time of light change in minutes 
local runtime = 120 --how long to run simulation in minutes 

local lights = {37, 100, 43, 94, 109, 4, 29, 130}  --IDs of lights to use in simulation 
local nrlights = #lights --nr of light devices listed above 

local start = os.time() 
local endtime = start + runtime*minute/1000 -- after how many minutes exit simulation 

while os.time() < endtime do 

  local rndlight = tonumber(lights[math.random(nrlights)]) 
  local rnd = math.random(nrlights) --make it more random 
  local lightstatus = fibaro:getValue(rndlight, 'value') 
  fibaro:debug('light ID:'..rndlight..' status:'..lightstatus) 
  -- turn on the light if off or turn off if on 
  if  tonumber(lightstatus) == 0 then fibaro:call(rndlight, 'turnOn') else fibaro:call(rndlight, 'turnOff') end 
  
  local sleeptime = math.random(rndmaxtime*minute) 
  fibaro:sleep(sleeptime) 
  
  local sleeptimemin = math.abs(sleeptime/60000) 
  fibaro:debug('sleeptime:'..sleeptimemin) 

end 

--turn Off all lights 
for i = 1, nrlights do 
  rndlight = tonumber(lights[i]) 
  fibaro:call(rndlight, 'turnOff') 
end 

fibaro:call(11, 'sendPush', "Lights simulation stopped") 
fibaro:debug('END')
