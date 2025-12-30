Curse_Item_Mod.Item = {}
Curse_Item_Mod.CollectibleTable = {}
local function AddItemID(name)
    Curse_Item_Mod.Item[name] = Isaac.GetItemIdByName(name)
    if Curse_Item_Mod.Item[name] == -1 then
        print("Item Named "..name.." not found")
    end
end

local function AddItemFile(path)
    local item = require("ci_sprites.items."..path)
    Curse_Item_Mod.CollectibleTable[item.CollectibleID] = item
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

function Curse_Item_Mod.Item:GetItemTagCount(player, tag)--player, string tag
    local collectibleCount = Isaac.GetItemConfig():GetCollectibles().Size--注：itemconfig相关的类有bug，慎用
    local result = 0
    for index = 1, collectibleCount, 1 do
        if Curse_Item_Mod.CollectibleTable[index] ~= nil then
            for __, singleTag in pairs(Curse_Item_Mod.CollectibleTable[index]) do
                if singleTag == tag then
                    result = result + 1
                end  
            end
        end
    end
    return result
end 