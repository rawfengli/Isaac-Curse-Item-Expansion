Curse_Item_Mod = RegisterMod("MyMode", 1)

--加载lib等文件
local function IncludeFile(filePath)
    require(filePath)
end

IncludeFile("sprites.commons.lib.lib")

local Unknown_Curse_ID = Isaac.GetItemIdByName("Unknown Curse")
local Blind_Curse_ID = Isaac.GetItemIdByName("Blind Curse")

-- The Unknown Curse Item Function
local Unknown_Curse_Item_BlackHeartNum = 2

function Curse_Item_Mod:UnknownCurseItemPostNewlevel()
    local player = Isaac.GetPlayer(0)
    if player:HasCollectible(Unknown_Curse_ID) then

        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_THE_UNKNOWN, showName)

        player:AddBlackHearts(Unknown_Curse_Item_BlackHeartNum)
    end 
end

function Curse_Item_Mod:UnknownCurseItemPostNewRoom()
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

Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Curse_Item_Mod.UnknownCurseItemPostNewlevel)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Curse_Item_Mod.UnknownCurseItemPostNewRoom)

-- end

-- The Blind Curse Item Function

local Blind_Curse_Item_Damage = 0.16
local Blind_Curse_Item_Tears = 0.10
local Blind_Curse_Item_Luck = 0.1
function Curse_Item_Mod:ReEvaluateItems()
    local player = Isaac.GetPlayer()
    player:AddCacheFlags(CacheFlag.CACHE_ALL)
    player:EvaluateItems()
end

function Curse_Item_Mod:BlindCurseItemEvaluateCache(player, cacheFlags)
    if player:HasCollectible(Blind_Curse_ID) then
        local collectibleCount = player:GetCollectibleCount()
        -- DamageFlags
        if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + collectibleCount * Blind_Curse_Item_Damage
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
end

function Curse_Item_Mod:BlindCurseItemPostNewRoom()
    local player = Isaac.GetPlayer(0)
    if player:HasCollectible(Blind_Curse_ID) then

        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_BLIND, showName)

    end 
end

function Curse_Item_Mod:BlindCurseItemPostNewLevel()
    local player = Isaac.GetPlayer(0)
    if player:HasCollectible(Blind_Curse_ID) then

        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_BLIND, showName)

    end   
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Curse_Item_Mod.BlindCurseItemEvaluateCache)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Curse_Item_Mod.BlindCurseItemPostNewLevel)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Curse_Item_Mod.BlindCurseItemPostNewRoom);
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Curse_Item_Mod.ReEvaluateItems)
--end