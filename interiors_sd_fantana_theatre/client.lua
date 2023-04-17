---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresYMAPS()    -- RequestImap
    if Config.Unknow == true then
        RequestImap(-1667265438)  -- Lemoyne -- Saint Denis -- Fantana Theatre -- signs on building 1
        RequestImap(175578406)  -- Lemoyne -- Saint Denis -- Fantana Theatre -- signs on building 2
        RequestImap(1137646647) -- Lemoyne -- Saint Denis -- Fantana Theatre -- fantana doors (fills hole)
        RequestImap(-898081380)   -- Lemoyne -- Saint Denis -- Fantana Theatre -- fantana theatre interior
        RequestImap(-468635897)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 1 out front (advertisement)
        RequestImap(-771786794)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 2 picture
        RequestImap(-626641013)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 3 scull
        RequestImap(1088045886)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 4 (advertisement)
        RequestImap(-1678761663)   -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 5 (advertisement)
        RequestImap(535384482)     -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 6 (advertisement)
        RequestImap(1724413302)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 7 (advertisement)
        RequestImap(-1267247536)  -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 8 (advertisement)         
    end      
end

function EnableResouresINTERIORS(x, y, z)  
    local interior = GetInteriorAtCoords(x, y, z)  
    --[[
        [29698] = {x=-241.58325195313,y=769.90649414063,z=117.54511260986,typeHashId=-565068911,typeHashName="val_saloon2_int",rpf="val_saloon2_int.rpf"},
        29698 	-565068911 	val_saloon2_int 	l_00260edcej   
    --]]
    ActivateInteriorEntitySet(interior, "val_saloon2_int")       
    if Config.Unknow == true then  
        ActivateInteriorEntitySet(interior, "l_00260edcej")         
    end   

end

-- currently there are two hitching posts. 

----------- turn off the bar ------
function DisableResourcesYMAPS() -- RemoveImap
    RemoveImap(-1667265438)  -- Lemoyne -- Saint Denis -- Fantana Theatre -- signs on building 1
    RemoveImap(175578406)  -- Lemoyne -- Saint Denis -- Fantana Theatre -- signs on building 2
    RemoveImap(1137646647) -- Lemoyne -- Saint Denis -- Fantana Theatre -- fantana doors (fills hole)
    RemoveImap(-898081380)   -- Lemoyne -- Saint Denis -- Fantana Theatre -- fantana theatre interior
    RemoveImap(-468635897)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 1 out front (advertisement)
    RemoveImap(-771786794)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 2 picture
    RemoveImap(-626641013)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 3 scull
    RemoveImap(1088045886)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 4 (advertisement)
    RemoveImap(-1678761663)   -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 5 (advertisement)
    RemoveImap(535384482)     -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 6 (advertisement)
    RemoveImap(1724413302)    -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 7 (advertisement)
    RemoveImap(-1267247536)  -- Lemoyne -- Saint Denis -- Fantana Theatre -- sign option 8 (advertisement)        
end

function DisableResourcesINTERIORS(x, y, z)  
    local interior = GetInteriorAtCoords(x, y, z)    
    DeactivateInteriorEntitySet(interior, "val_saloon2_int")     
    DeactivateInteriorEntitySet(interior, "l_00260edcej")         
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

 