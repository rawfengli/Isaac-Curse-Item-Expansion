local itemName = "Maze Curse"
local Maze_Curse_ID = Curse_Item_Mod.Item[itemName]

function Curse_Item_Mod:MazeCurseMoveToRandomRoom(Maze_Curse, rng, player)
    
    local game = Game()
    local rng = player:GetCollectibleRNG(Maze_Curse_ID)
    local sed = rng:RandomInt(114514)
    game:MoveToRandomRoom(true, sed, player)
    return {
        Discharge = true,
        Remove = false,
        ShowAnim = true
    }
end

function Curse_Item_Mod:PickUpMazeCurse(player, cacheFlags)
    if player:HasCollectible(Maze_Curse_ID) then
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            local level = Game():GetLevel()
            local showName = false
            level:AddCurse(LevelCurse.CURSE_OF_MAZE, showName)
        end
    end
end
function Curse_Item_Mod:MazeCursePostRoom()
    local player = Isaac.GetPlayer(0)
    if player:HasCollectible(Maze_Curse_ID) then
        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_MAZE, showName)
    end  
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Curse_Item_Mod.MazeCurseMoveToRandomRoom, Maze_Curse_ID)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Curse_Item_Mod.PickUpMazeCurse)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Curse_Item_Mod.MazeCursePostRoom)
