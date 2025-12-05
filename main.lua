local mod = RegisterMod("Isaac-Curse-Item-Expansion", 1)

local tools = require("toolclass")

local Unknown_Curse_ID = Isaac.GetItemIdByName("Unknown Curse")
local Blind_Curse_ID = Isaac.GetItemIdByName("Blind Curse")

-- The Unknown Curse Item Function
local Unknown_Curse_Item_BlackHeartNum = 2

function mod:UnknownCurseItemPostNewlevel()
    local player = Isaac.GetPlayer(0)
    if player:HasCollectible(Unknown_Curse_ID) then

        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_THE_UNKNOWN, showName)

        player:AddBlackHearts(Unknown_Curse_Item_BlackHeartNum)
    end 
end

function mod:UnknownCurseItemPostNewRoom()
    local player = Isaac.GetPlayer(0)

    if player:HasCollectible(Unknown_Curse_ID) then
        -- Add Curse Of Unknown
        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_THE_UNKNOWN, showName)
        -- Add Wafer Effect 
       local effects = player:GetEffects()
       effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER)
    end 
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.UnknownCurseItemPostNewlevel)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.UnknownCurseItemPostNewRoom)

-- end

-- The Blind Curse Item Function

local Blind_Curse_Item_Damage = 0.16
local Blind_Curse_Item_Tears = 0.10
local Blind_Curse_Item_Luck = 0.1
function mod:ReEvaluateItems()
    local player = Isaac.GetPlayer()
    player:AddCacheFlags(CacheFlag.CACHE_ALL)
    player:EvaluateItems()
end

function mod:BlindCurseItemEvaluateCache(player, cacheFlags)
    if player:HasCollectible(Blind_Curse_ID) then
        local collectibleCount = player:GetCollectibleCount()
        -- DamageFlags
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + collectibleCount * Blind_Curse_Item_Damage
        end
        -- TearsFlags
        if cacheFlags & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then

            local originalFireDelay = player.MaxFireDelay
            local originalTears = 30 / (originalFireDelay + 1)
            local currentTears = originalTears + collectibleCount * Blind_Curse_Item_Tears
            local currentFireDelay = 30 / currentTears - 1
            player.MaxFireDelay = currentFireDelay
        end
        -- LuckFlags
        if cacheFlags & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + collectibleCount * Blind_Curse_Item_Luck
        end 
    end
end

function mod:BlindCurseItemPostNewRoom()
    local player = Isaac.GetPlayer(0)
    if player:HasCollectible(Blind_Curse_ID) then

        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_BLIND, showName)

    end 
end

function mod:BlindCurseItemPostNewLevel()
    local player = Isaac.GetPlayer(0)

    if player:HasCollectible(Blind_Curse_ID) then

        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_BLIND, showName)

    end   
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.BlindCurseItemEvaluateCache)
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.BlindCurseItemPostNewLevel)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.BlindCurseItemPostNewRoom);
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.ReEvaluateItems)
--end