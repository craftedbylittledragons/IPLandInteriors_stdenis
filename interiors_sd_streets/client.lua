---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false 

----------- turn on the bar ------
function EnableResouresIMAP()    -- RequestImap      
    if Config.Unknow == true then
        --RequestImap(___________________) -- Something relating to BizTemplate
        --## Saint Denis ##--
        RequestImap(-1221875648)   -- Lemoyne -- Saint Denis -- Fire at Coffery Ranch
        RequestImap(-2093605706)   -- Lemoyne -- Saint Denis 
        RequestImap(-342806042)    -- Lemoyne -- Saint Denis -- Tram Wreck
        RequestImap(1255880931)    -- Lemoyne -- Saint Denis -- Wreckage from the Tram
        RequestImap(2070068088)    -- Lemoyne -- Saint Denis 
        RequestImap(220493865)     -- Lemoyne -- Saint Denis 
        RequestImap(281772765)     -- Lemoyne -- Saint Denis -- Streets -- Crates #1
        RequestImap(490883533)     -- Lemoyne -- Saint Denis -- Streets -- Crates #2   ----------------------- Saint Denis
        RequestImap(-2096572276)
        RequestImap(2015532863)
        RequestImap(-800942395)
        --RequestImap(-741366935)
        --RequestImap(-1593790123)
        RequestImap(-595698218)
        RequestImap(-1269989522)
        RequestImap(-1995815064)
        RequestImap(1136457806) -- tram crash
        --RequestImap(-342806042) -- tram crash
        --RequestImap(1255880931) -- tram crash
        --RequestImap(1676972066) -- tram crash
        RequestImap(-643411908)
        RequestImap(-1901860833)
        RequestImap(-1225383143)
        RequestImap(206289712)
        RequestImap(1405627586)
        RequestImap(-1889108254)
        --RequestImap(-1583923165)
        RequestImap(1726243396)
        --RequestImap(96746001)
        RequestImap(1871261290)
        RequestImap(1767170589)
        RequestImap(396094389)
        RequestImap(68538405)
        RequestImap(-540286923)
        RequestImap(1017355491)
        RequestImap(-920505696)
        RequestImap(-596723840)
        --RequestImap(-1026473536)
        RequestImap(-1762770596)
        --RequestImap(-516683274)
        RequestImap(-1004522372)
        RequestImap(281772765)
        --RequestImap(-2084311522)
        RequestImap(489834626)
        RequestImap(1628286919)
        RequestImap(-704461521)
        --RequestImap(1082980257)
        --RequestImap(-1725465949)
        RemoveImap(1821956151) -- Entrance to bar above Saint Denis gun shop at 2711.64 -1293.62 60.46
        RequestImap(-1993960878)
        RequestImap(204868257)
        RequestImap(432272547)
        --RequestImap(1895127686)
        RequestImap(1461266126)
        --RequestImap(-1473336090)
        RequestImap(-1490034522)
        RequestImap(-205116461)
        RequestImap(-1013403664)
        RequestImap(-670748311)
        RequestImap(-2124415277)
        RequestImap(-836433697)
        RequestImap(-494733971)
        RequestImap(490883533)
        RequestImap(752665876)
        ------------------------------------- #### END OF SAINT DENIS ####       
    end 
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
function DisableResourcesIMAPS() --- RemoveImap 
    --RemoveImap(___________________) -- Something relating to BizTemplate    
    --## Saint Denis ##--
    RemoveImap(-1221875648)   -- Lemoyne -- Saint Denis -- Fire at Coffery Ranch
    RemoveImap(-2093605706)   -- Lemoyne -- Saint Denis 
    RemoveImap(-342806042)    -- Lemoyne -- Saint Denis -- Tram Wreck
    RemoveImap(1255880931)    -- Lemoyne -- Saint Denis -- Wreckage from the Tram
    RemoveImap(2070068088)    -- Lemoyne -- Saint Denis 
    RemoveImap(220493865)     -- Lemoyne -- Saint Denis 
    RemoveImap(281772765)     -- Lemoyne -- Saint Denis -- Streets -- Crates #1
    RemoveImap(490883533)     -- Lemoyne -- Saint Denis -- Streets -- Crates #2 
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

 