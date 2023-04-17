---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresYMAPS()    -- RequestImap      
    if Config.Unknow == true then
        --[[  
        --RequestImap(___________________) -- Something relating to BizTemplate
        --]]
        --#### Boats ####--  casino_boat
        RequestImap(-614421509)   -- Casino boat -- Shell
        RequestImap(604920544)    -- Casino boat -- Upstairs interior
        RequestImap(1382135686)   -- Casino boat -- Main room interior
        RequestImap(-1968130469)  -- Casino boat -- Railings
        RequestImap(-276259505)   -- Casino boat -- Railings
        RequestImap(-723094901)   -- Ferry Boat
        --#### End of Boats ####--        
----------------------- Casino boat
RequestImap(-873881483)
RequestImap(881979872)
RequestImap(-614421509) -- boat shell
RequestImap(604920544)  -- upstairs interior
RequestImap(1382135686) -- main room interior
RequestImap(-1968130469) -- railings
RequestImap(-276259505) -- railings
RequestImap(-1716205818)
RequestImap(1056170594)
RequestImap(1157695860)
RequestImap(1859948183)
RequestImap(-1688366042)
------------------------------------- #### END OF CASINO ####
    end      
end

function EnableResouresINTERIORS(x, y, z)  --- ActivateInteriorEntitySet 
    --[[  
    local interior = GetInteriorAtCoords(x, y, z)  
    ActivateInteriorEntitySet(interior, "___________________")       
    if Config.Unknow == true then  
        ActivateInteriorEntitySet(interior, "___________________")         
    end   
    --]]

end

-- currently there are two hitching posts. 

----------- turn off the bar ------
function DisableResourcesYMAPS() --- RemoveImap    
     --[[  
    --RemoveImap(___________________) -- Something relating to BizTemplate  
    --]] 
    --#### Boats ####--  casino_boat
    RemoveImap(-614421509)   -- Casino boat -- Shell
    RemoveImap(604920544)    -- Casino boat -- Upstairs interior
    RemoveImap(1382135686)   -- Casino boat -- Main room interior
    RemoveImap(-1968130469)  -- Casino boat -- Railings
    RemoveImap(-276259505)   -- Casino boat -- Railings
    RemoveImap(-723094901)   -- Ferry Boat
    --#### End of Boats ####--         
end

function DisableResourcesINTERIORS(x, y, z)  --- DeactivateInteriorEntitySet
    --[[  
    local interior = GetInteriorAtCoords(x, y, z)    
    DeactivateInteriorEntitySet(interior, "___________________")     
    DeactivateInteriorEntitySet(interior, "___________________")   
    --]]      
end    
 
 
-----------------------------------------------------
---remove all on resource stop---
-----------------------------------------------------
AddEventHandler('onResourceStop', function(resource) 
    if resource == GetCurrentResourceName() then     
        -- when resource stops disable them, admin is restarting the script
        DisableResourcesYMAPS() 
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
        DisableResourcesYMAPS() 
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
        DisableResourcesYMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)

        -- basically run once after character has loadded in  
        EnableResouresYMAPS() 
        EnableResouresINTERIORS(Config.x, Config.y, Config.z)
        interiorsActive = true
        unlockDoors()  
    end
end)

 