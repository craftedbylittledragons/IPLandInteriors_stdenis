---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresYMAPS()     -- RequestImap     
    if Config.Unknow == true then
        ----------------------- Saint Denis THEATRE
        RequestImap(-278745837) -- saint denis big theatre
        RequestImap(-41173958) -- saint denis big theatre
        RequestImap(1160690623) -- saint denis big theatre
        RequestImap(-660075384) -- saint denis big theatre
        RequestImap(149553684) -- saint denis big theatre
        --RequestImap(1547403545) -- saint denis big theatre one of the signs outside
        --RequestImap(808576710) -- saint denis big theatre one of the signs outside
        --RequestImap(-775951892) -- saint denis big theatre one of the signs outside
        --RequestImap(137316925) -- saint denis big theatre one of the signs outside
        --RequestImap(1431947993) -- saint denis big theatre one of the signs outside
        ------------------------------------- #### END OF SAINT DENIS THEATRE ####
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
function DisableResourcesYMAPS()   -- RemoveImap
    --[[
    RemoveImap(-226455701)   -- Lemoyne -- Saint Denis -- Police Office -- Bounty Board
    RemoveImap(350100475)    -- Lemoyne -- Saint Denis -- Police Office -- Prison Cellar doors  
    --]]
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

 