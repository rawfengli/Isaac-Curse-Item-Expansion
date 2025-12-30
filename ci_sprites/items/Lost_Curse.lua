local Lost_Curse = {}

Lost_Curse.Name = "Lost Curse"
Lost_Curse.CollectibleID = Curse_Item_Mod.Item[Lost_Curse.Name]
Lost_Curse.Tag = {}

do --function 
    function Curse_Item_Mod:OpenRedRoom()
        local player = Isaac.GetPlayer(0)
        if player:HasCollectible(Lost_Curse.CollectibleID) then
            local rng = player:GetCollectibleRNG(Lost_Curse.CollectibleID)
            local chance = rng:RandomInt(100)
            if chance < 60 then
                player:UseCard(Card.CARD_SOUL_CAIN)
            end
        end
    end

    function Curse_Item_Mod:LostCurseItemPostNewRoom()
        local player = Isaac.GetPlayer(0)
        if player:HasCollectible(Lost_Curse.CollectibleID) then 
            local level = Game():GetLevel()
            local showName = false
            level:AddCurse(LevelCurse.CURSE_OF_THE_LOST, showName)
        end
    end
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Curse_Item_Mod.OpenRedRoom)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Curse_Item_Mod.LostCurseItemPostNewRoom)

return Lost_Curse

