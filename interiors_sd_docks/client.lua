---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresYMAPS()    -- RequestImap      
    if Config.Unknow == true then
        RequestImap(___________________) -- Something relating to BizTemplate
    end      


----------------------- Saint Denis Docks
RequestImap(-445068262)
RequestImap(-801609437)
RequestImap(1509141447)
RequestImap(-469909433)
RequestImap(-1461530058)
RequestImap(1826022799)
RemoveImap(-1859413313)
RequestImap(1394163483)
--RequestImap(942470447)
RequestImap(-483649675)
--RequestImap(-782601262)
RequestImap(-1170563128)
RequestImap(212587871)
RequestImap(-436566493)
--RequestImap(-677790400)
RequestImap(143811737)
--RequestImap(1679182807)
RequestImap(-1512794226)
RequestImap(146172383)
RequestImap(876228895)
--RequestImap(1417687142)
RequestImap(-2035101386)
RequestImap(1520435387)
--RequestImap(1078633574)
RequestImap(1305074360)
RequestImap(1048677741)
RequestImap(1284188544)
RequestImap(-1986089134)
RequestImap(913995529)
RequestImap(-730093764)
RequestImap(-359734366)
RequestImap(175173994)
RequestImap(-686953321)
--RequestImap(54029413)
--RequestImap(-739754595)
RequestImap(-931280709)
RequestImap(-1737485501)
--RequestImap(-1070234238)
RequestImap(191078900)
RequestImap(695709062)
RequestImap(1395510290)
RequestImap(-1366130296)
RequestImap(1205820933)
RequestImap(195206081)
RequestImap(1355914142)
--RequestImap(165972019)
RequestImap(-1036688493)
RequestImap(-30157790)
RequestImap(-929277449)
RequestImap(-801609437)
------------------------------------- #### END OF SAINT DENIS DOCKS ####    
end

function EnableResouresINTERIORS(x, y, z)  --- ActivateInteriorEntitySet
    local interior = GetInteriorAtCoords(x, y, z)  
    --[[ 
    --]]
    ActivateInteriorEntitySet(interior, "___________________")       
    if Config.Unknow == true then  
        ActivateInteriorEntitySet(interior, "___________________")         
    end   

end

-- currently there are two hitching posts. 

----------- turn off the bar ------
function DisableResourcesYMAPS() --- RemoveImap 
    RemoveImap(___________________) -- Something relating to BizTemplate    
end

function DisableResourcesINTERIORS(x, y, z)  --- DeactivateInteriorEntitySet
    local interior = GetInteriorAtCoords(x, y, z)    
    DeactivateInteriorEntitySet(interior, "___________________")     
    DeactivateInteriorEntitySet(interior, "___________________")         
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

 