local itemName = "Portable Pill"
local Portable_Pill_ID = Curse_Item_Mod.Item[itemName]

local Last_Use_Pill = PillEffect.PILLEFFECT_NULL -- 如果依然有地方需要使用 “上一次吃的药丸” 就把这个改成全局变量
local MultipleX = 4 -- 在清理4个房间后使用一次上一次使用的药丸
function Curse_Item_Mod:TriggerLastUsePill()
    local player = Isaac.GetPlayer(0)
    if Last_Use_Pill ~= PillEffect.PILLEFFECT_NULL and player:HasCollectible(Portable_Pill_ID) then
        if Curse_Item_Mod.IRoom:IsMultipleOfX(MultipleX) then
            player:UsePill(Last_Use_Pill, PillColor.PILL_NULL)  
        end
    end
end

function Curse_Item_Mod:RecordNewUsePill(pillEffect, player, useFlag)
    Last_Use_Pill = pillEffect
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_USE_PILL, Curse_Item_Mod.RecordNewUsePill)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Curse_Item_Mod.TriggerLastUsePill)
