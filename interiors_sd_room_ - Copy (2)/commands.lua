
-----------------------------------------------------
------ admin commands to control the bar ----------
--- add admind perms later
-----------------------------------------------------
RegisterCommand("ValSaloon_turnon", function(source, args)    
    if Config.Commands == true then   
        TriggerEvent( "ValSaloon:turnon", "ok" ) 
    else 
        print("Turn On IMAP is disabled in script "..Config.Label)
    end
end)
RegisterNetEvent('ValSaloon:turnon')
AddEventHandler('ValSaloon:turnon', function(no_String)  
	EnableResouresIMAP() 
    EnableResouresINTERIORS(Config.x, Config.y, Config.z)
    Wait(800) 
end) 
  
RegisterCommand("ValSaloon_turnoff", function(source, args)  
    if Config.Commands == true then       
        TriggerEvent( "ValSaloon:turnoff", "ok" ) 
    else 
        print("Turn Off IMAP is disabled in script "..Config.Label)
    end
end)
RegisterNetEvent('ValSaloon:turnoff')
AddEventHandler('ValSaloon:turnoff', function(no_String)  
	DisableResourcesIMAPS()
    DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
    Wait(800) 
end)  
