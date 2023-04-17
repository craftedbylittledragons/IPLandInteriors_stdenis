---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresYMAPS()     -- RequestImap     
    if Config.Unknow == true then
        RequestImap(-226455701)   -- Lemoyne -- Saint Denis -- Police Office -- Bounty Board
        RequestImap(350100475)    -- Lemoyne -- Saint Denis -- Police Office -- Prison Cellar doors 
        ----------------------- Prison
        RequestImap(350100475) --Cellar doors
        RequestImap(728046625)
        RequestImap(2033090463)
        RequestImap(826576088)
        ------------------------------------- #### END Prison ####
    end      
end

function EnableResouresINTERIORS(x, y, z)  
    local interior = GetInteriorAtCoords(x, y, z)  
    --[[
	ActivateInteriorEntitySets(3074, "Saint Denis general store", {
		"_p_bread06x_dressing",
		"_p_bread06x_group",
		"_p_cigar02x_dressing",
		"_p_cigar02x_group",
		"_p_cigarettebox01x_dressing",
		"_p_cigarettebox01x_group",
		"_s_biscuits01x_dressing",
		"_s_biscuits01x_group",
		"_s_brandy01x_group",
		"_s_candyBag01x_red_group",
		"_s_cheeseWedge1x_dressing",
		"_s_cheeseWedge1x_group",
		"_s_chocolateBar02x_dressing",
		"_s_chocolateBar02x_group",
		"_s_coffeeTin01x_dressing",
		"_s_coffeeTin01x_group",
		"_s_crackers01x_dressing",
		"_s_crackers01x_group",
		"_s_inv_gin01x_dressing",
		"_s_inv_gin01x_group",
		"_s_inv_rum01x_group",
		"_s_inv_tabacco01x_dressing",
		"_s_inv_tabacco01x_group",
		"_s_inv_whiskey01x_dressing",
		"_s_inv_whiskey01x_group"
	}) 
    --]]
    ActivateInteriorEntitySet(interior, "val_saloon2_int")       
    if Config.Unknow == true then  
        ActivateInteriorEntitySet(interior, "l_00260edcej")         
    end   

end

-- currently there are two hitching posts. 

----------- turn off the bar ------
function DisableResourcesYMAPS()   -- RemoveImap
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

 