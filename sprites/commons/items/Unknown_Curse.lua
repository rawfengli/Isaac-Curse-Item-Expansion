local itemName = "Unknown Curse"
local Unknown_Curse_ID = Curse_Item_Mod.Item[itemName]

local Unknown_Curse_Item_BlackHeartCount1 = 1
local Unknown_Curse_Item_BlackHeartCount2 = 2

function Curse_Item_Mod:UnknownCurseItemPostNewlevel()
    local player = Isaac.GetPlayer(0)
    if player:HasCollectible(Unknown_Curse_ID) then
        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_THE_UNKNOWN, showName)

        local heartCount = player:GetHearts() + player:GetSoulHearts() + player:GetBoneHearts()
        if heartCount <= 10 then
            player:AddBlackHearts(Unknown_Curse_Item_BlackHeartCount2)
        else 
            if player:GetSoulHearts() == 0 then
                player:AddBlackHearts(Unknown_Curse_Item_BlackHeartCount1);
            end
        end
    end 
end
 
function Curse_Item_Mod:UnknownCurseItemPostNewRoom()
    local player = Isaac.GetPlayer(0)

    if player:HasCollectible(Unknown_Curse_ID) then
        -- Add Curse Of Unknown/添加血量未知诅咒
        local level = Game():GetLevel()
        local showName = false
        level:AddCurse(LevelCurse.CURSE_OF_THE_UNKNOWN, showName)
        -- Add Wafer Effect/添加圣饼效果
       local effects = player:GetEffects()
       effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER)
    end 
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Curse_Item_Mod.UnknownCurseItemPostNewlevel)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Curse_Item_Mod.UnknownCurseItemPostNewRoom)