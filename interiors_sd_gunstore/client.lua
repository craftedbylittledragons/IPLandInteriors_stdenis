---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresIMAP()     -- RequestImap     
    if Config.Unknow == true then
        RequestImap(-226455701)   -- Lemoyne -- Saint Denis -- Police Office -- Bounty Board
        RequestImap(350100475)    -- Lemoyne -- Saint Denis -- Police Office -- Prison Cellar doors 
    end      
end

function EnableResouresINTERIORS(x, y, z)  
    local interior = GetInteriorAtCoords(x, y, z)  
    --[[
	ActivateInteriorEntitySets(2050, "Saint Denis gun store", {
		"_s_inv_arrowammo01x_dressing",
		"_s_inv_highvlcty_pstAmmo01x_group",
		"_s_inv_highvlcty_revAmmo01x_group",
		"_s_inv_highvlcty_rifleAmmo01x_group",
		"_s_inv_pistolAmmo01x_dressing",
		"_s_inv_pistolAmmo01x_group",
		"_s_inv_revolverAmmo01x_dressing",
		"_s_inv_revolverAmmo01x_group",
		"_s_inv_rifleAmmo01x_dressing",
		"_s_inv_rifleAmmo01x_group",
		"_s_inv_shotgunAmmo01x_dressing",
		"_s_inv_shotgunAmmo01x_group",
		"_s_inv_slug_shotgunAmmo01x_group",
		"_s_inv_varmint_rifleammo01x_group"
	})
    --]]
    ActivateInteriorEntitySet(interior, "val_saloon2_int")       
    if Config.Unknow == true then  
        ActivateInteriorEntitySet(interior, "l_00260edcej")         
    end   

end

-- currently there are two hitching posts. 

----------- turn off the bar ------
function DisableResourcesIMAPS()   -- RemoveImap
    RemoveImap(-226455701)   -- Lemoyne -- Saint Denis -- Police Office -- Bounty Board
    RemoveImap(350100475)    -- Lemoyne -- Saint Denis -- Police Office -- Prison Cellar doors  
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

 