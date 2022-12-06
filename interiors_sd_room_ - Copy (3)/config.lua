Config = {}
Config.Commands = true  -- For testing set to false for live server
Config.TeleportME = true -- For testing set to false for live server

-- ipl / imap
Config.Sign = true 

-- interiors
Config.Posts = true  

Config.Label = "House Template"
Config.x = -309.288
Config.y = 808.374
Config.z = 119.187   
 
Config.door_hash_v1 = {
    ----Valentine 
}

Config.door_hash_v2 = {
    --"Name": "Room 1", // Saint Denis
    --"DoorsStatus": [ 2634.68, -1225.02, 58.6 ],
    --"Doors":  [ 2634.681, -1225.021, 58.59612, 89.478607177734 ]    
--[entity] ={entity,hash_code,"obj_name",2634.681, -1225.021, 58.59612},  
}  

--------------------------------------------------
-- Teleport Cofiguration  ---------------------------
--------------------------------------------------
Config.definedkey = { named = "G", hash = 0x760A9C6F }
Config.TeleporterPrompt = "Use Door [~e~"..  Config.definedkey.named  .."~q~]"
Config.TeleportDistance = 0.5
Config.WaitTimer = 1000
Config.FadeTimer = 2

Config.TeleportEnter_On = false 
--"TPEnter": [ 2633.843, -1224.484, 58.64468 ],
Config.Room = {x = 2634.843, y= -1225.484, z=58.64468, h = 000.00 } -- upstairs right  - room exist - structure interior missing 
 
Config.TeleportExit_On = false 
--"TPLeave": [ 2635.453, -1224.474, 58.63639 ],
Config.Room = {x = 2634.453, y= -1225.474, z=58.63639 , h = 000.00 }
 