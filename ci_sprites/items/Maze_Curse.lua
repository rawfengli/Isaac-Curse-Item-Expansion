local Maze_Curse = {}

Maze_Curse.Name = "Maze Curse"
Maze_Curse.CollectibleID = Curse_Item_Mod.Item[Maze_Curse.Name]
Maze_Curse.Tag = {}

do --function
    function Curse_Item_Mod:MazeCurseMoveToRandomRoom(__, rng, player)
        
        local game = Game()

        local sed = rng:RandomInt(114514)
        game:MoveToRandomRoom(true, sed, player)
        return {
            Discharge = true,
            Remove = false,
            ShowAnim = true
        }
    end

    function Curse_Item_Mod:PickUpMazeCurse(player, cacheFlags)
        if player:HasCollectible(Maze_Curse.CollectibleID) then
            if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                local level = Game():GetLevel()
                local showName = false
                level:AddCurse(LevelCurse.CURSE_OF_MAZE, showName)
            end
        end
    end
    function Curse_Item_Mod:MazeCursePostRoom()
        local player = Isaac.GetPlayer(0)
        if player:HasCollectible(Maze_Curse.CollectibleID) then
            local level = Game():GetLevel()
            local showName = false
            level:AddCurse(LevelCurse.CURSE_OF_MAZE, showName)
        end  
    end
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Curse_Item_Mod.MazeCurseMoveToRandomRoom, Maze_Curse.CollectibleID)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Curse_Item_Mod.PickUpMazeCurse)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Curse_Item_Mod.MazeCursePostRoom)

return Maze_Curse
