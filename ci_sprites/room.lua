Curse_Item_Mod.IRoom = {}

Curse_Item_Mod.IRoom["GetHitNum"] = 0
Curse_Item_Mod.IRoom["CleanRoomNum"] = 0


function Curse_Item_Mod.IRoom:RefreshGetHitNum()
    Curse_Item_Mod.IRoom["GetHitNum"] = 0
end

function Curse_Item_Mod.IRoom:IsMultipleOfX(x)
    if Curse_Item_Mod.IRoom["CleanRoomNum"] % x == 0 then
        return true
    else   
        return false
    end
end

function Curse_Item_Mod.IRoom:IncGetHitNum()
    Curse_Item_Mod.IRoom["GetHitNum"] = Curse_Item_Mod.IRoom["GetHitNum"] + 1
end

function Curse_Item_Mod.IRoom:IncCleanRoomNum()
    Curse_Item_Mod.IRoom["CleanRoomNum"] = Curse_Item_Mod.IRoom["CleanRoomNum"] + 1
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Curse_Item_Mod.IRoom.IncGetHitNum, EntityType.ENTITY_PLAYER)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Curse_Item_Mod.IRoom.RefreshGetHitNum)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Curse_Item_Mod.IRoom.IncCleanRoomNum)

return Curse_Item_Mod.IRoom