--[[
local itemName = "Labyrinth Curse"
local Labyrinth_Curse_ID = Curse_Item_Mod.Item[itemName]

function  Curse_Item_Mod:MoveToRandomRoom()
    local game = Game()
    local player = Isaac.GetPlayer(0)
    game.MoveToRandomRoom(false, 1, player)
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Curse_Item_Mod.MoveToRandomRoom)
--]]
