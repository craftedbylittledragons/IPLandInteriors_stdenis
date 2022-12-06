---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresIMAP()          
    if Config.Unknow == true then  
        RequestImap(619024057)    -- Lemoyne -- Saint Denis -- Doctor office -- full interior with doors
        RequestImap(-473077489)    -- Lemoyne -- Saint Denis -- Doctor office -- Doors (fixes hole) no interior    
    end      
end

function EnableResouresINTERIORS(x, y, z)  
    local interior = GetInteriorAtCoords(x, y, z)  
    --[[

	ActivateInteriorEntitySets(34562, "Saint Denis doctor", {
		"SD_doc_curtain01",
		"_s_candyBag01x_red_group",
		"_s_chocolateBar02x_dressing",
		"_s_chocolateBar02x_group",
		"_s_inv_CocaineGum01x_dressing",
		"_s_inv_CocaineGum01x_group",
		"_s_inv_medicine01x_dressing",
		"_s_inv_medicine01x_group",
		"_s_inv_medicine_fty_dressing",
		"_s_inv_medicine_fty_group",
		"_s_inv_supertonic01x_dressing",
		"_s_inv_supertonic01x_group",
		"_s_inv_tonic01x_dressing",
		"_s_inv_tonic01x_group"
	}) 
    --]]
    ActivateInteriorEntitySet(interior, "val_saloon2_int")       
    if Config.Unknow == true then  
        ActivateInteriorEntitySet(interior, "l_00260edcej")         
    end   

end

-- currently there are two hitching posts. 

----------- turn off the bar ------
function DisableResourcesIMAPS() 
    RemoveImap(619024057)    -- Lemoyne -- Saint Denis -- Doctor office -- full interior with doors
    RemoveImap(-473077489)    -- Lemoyne -- Saint Denis -- Doctor office -- Doors (fixes hole) no interior 
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

 