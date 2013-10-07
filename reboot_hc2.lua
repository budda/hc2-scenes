HC2 = Net.FHttp("192.168.xxx.xxx") 
HC2:setBasicAuthentication("admin", "password") 

response, status, errorCode = HC2:POST("/api/settings/reboot", "data=reset") 

if errorCode == 0 
then 
  fibaro:log(status) 
else 
  fibaro:log("error") 
end 
