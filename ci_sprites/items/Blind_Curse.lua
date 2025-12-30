local Blind_Curse = {}

Blind_Curse.Name = "Blind Curse"
Blind_Curse.CollectibleID = Curse_Item_Mod.Item[Blind_Curse.Name]
Blind_Curse.Tag = {
    "Curse"
}
do -- function
    local Blind_Curse_Item_Damage = 0.16
    local Blind_Curse_Item_Tears = 0.10
    local Blind_Curse_Item_Luck = 0.1
    Blind_Curse.Function = {
        ReEvaluateItems = function(__)
            local player = Isaac.GetPlayer()
            player:AddCacheFlags(CacheFlag.CACHE_ALL)
            player:EvaluateItems()

        end,

        BlindCurseItemEvaluateCache = function(__, player, cacheFlags)
            if player:HasCollectible(Blind_Curse.CollectibleID) then
                local collectibleCount = player:GetCollectibleCount()
                -- DamageFlags
                if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
                    local AddDamage = collectibleCount * Blind_Curse_Item_Damage
                    AddDamage = Curse_Item_Mod.Lib["Damage"]:ModifyDirectDamage(AddDamage, player)
                    player.Damage = player.Damage + AddDamage
                end
                -- TearsFlags
                if cacheFlags & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then

                    local AddTears = collectibleCount * Blind_Curse_Item_Tears
                    local AddMaxFireDelay = Curse_Item_Mod.Lib["Tears"]:ModifyTears(AddTears, player)
                    player.MaxFireDelay = player.MaxFireDelay + AddMaxFireDelay
                end
                -- LuckFlags
                if cacheFlags & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
                    player.Luck = player.Luck + collectibleCount * Blind_Curse_Item_Luck
                end 
            end
        end,
        BlindCurseItemPostNewRoom = function (__)
            local player = Isaac.GetPlayer(0)
            if player:HasCollectible(Blind_Curse.CollectibleID) then
                local level = Game():GetLevel()
                local showName = false
                level:AddCurse(LevelCurse.CURSE_OF_BLIND, showName)

            end 
        end,
        BlindCurseItemPostNewLevel = function (__)
            local player = Isaac.GetPlayer(0)
            if player:HasCollectible(Blind_Curse.CollectibleID) then

                local level = Game():GetLevel()
                local showName = false
                level:AddCurse(LevelCurse.CURSE_OF_BLIND, showName)

            end   
        end
    }

end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Blind_Curse.Function.BlindCurseItemEvaluateCache)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Blind_Curse.Function.BlindCurseItemPostNewLevel)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM , Blind_Curse.Function.BlindCurseItemPostNewRoom);
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_UPDATE   , Blind_Curse.Function.ReEvaluateItems)

return Blind_Curse
