---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresIMAP() 
    --[[  
    if Config.Unknow == true then
        RequestImap(666617953) -- Something relating to valentine saloon
    end 
    --]]     
end

function EnableResouresINTERIORS(x, y, z)  
    --[[  
    local interior = GetInteriorAtCoords(x, y, z)  
    ActivateInteriorEntitySet(interior, "__________________")   -- main 
    if Config.Unknow == true then 
        ActivateInteriorEntitySet(interior, "__________________") -- sub
    end   
    --]]  
end

-- currently there are two hitching posts. 

----------- turn off the bar ------
function DisableResourcesIMAPS()  
    --[[     
    RemoveImap(666617953) -- Something relating to valentine saloon 
    --]]  
end

function DisableResourcesINTERIORS(x, y, z) 
    --[[   
    local interior = GetInteriorAtCoords(x, y, z)   
    DeactivateInteriorEntitySet(interior, "val_saloon_int")  --- main
    DeactivateInteriorEntitySet(interior, "4_chair_poker_set")  --- sub
    --]]  
end    
 
 
-----------------------------------------------------
---remove all on resource stop---
-----------------------------------------------------
AddEventHandler('onResourceStop', function(resource) 
    if resource == GetCurrentResourceName() then     
        -- when resource stops disable them, admin is restarting the script
        DisableResourcesIMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
    end
end)

-----------------------------------------------------
--- clear all on resource start ---
-----------------------------------------------------
AddEventHandler('onResourceStart', function(resource) 
    if resource == GetCurrentResourceName() then         
        Citizen.Wait(3000)
        -- interiors loads all of these, so we need to disable them 
        DisableResourcesIMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
        Citizen.Wait(3000)        
        -- because the character is already logged in on resource "re"start
        character_selected = true
    end
end)
 

-----------------------------------------------------
-- Trigger when character is selected
-----------------------------------------------------
RegisterNetEvent("vorp:SelectedCharacter") -- NPC loads after selecting character
AddEventHandler("vorp:SelectedCharacter", function(charid) 
	character_selected = true
end)
  
-----------------------------------------------------
-- Main thread that controls the script
-----------------------------------------------------
Citizen.CreateThread(function()
    while character_selected == false do 
        Citizen.Wait(1000)
    end 
    if character_selected == true and interiorsActive == false then 
        --- cleanup any previous scripts loading content
        DisableResourcesIMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)

        -- basically run once after character has loadded in  
        EnableResouresIMAP() 
        EnableResouresINTERIORS(Config.x, Config.y, Config.z)
        interiorsActive = true
        unlockDoors()  
    end
end)

 