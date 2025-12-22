Curse_Item_Mod.Item = {}

local function AddItemID(name)
    Curse_Item_Mod.Item[name] = Isaac.GetItemIdByName(name)
    if Curse_Item_Mod.Item[name] == -1 then
        print("Item Named "..name.." not found")
    end
end

local function AddItemFile(path)
    require("sprites.commons.items."..path)
end

AddItemID("Blind Curse")
AddItemID("Unknown Curse")
AddItemID("Portable Pill")
AddItemID("Lost Curse")
AddItemID("Maze Curse")

AddItemFile("Blind_Curse")
AddItemFile("Unknown_Curse")
AddItemFile("Portable_Pill")
AddItemFile("Lost_Curse")
AddItemFile("Maze_Curse")

