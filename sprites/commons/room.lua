Curse_Item_Mod.IRoom = {}

Curse_Item_Mod.IRoom["GetHitNum"] = 0

function Curse_Item_Mod.IRoom:RefreshGetHitNum()
    Curse_Item_Mod.IRoom["GetHitNum"] = 0
end

function Curse_Item_Mod.IRoom:IncGetHitNum()
    Curse_Item_Mod.IRoom["GetHitNum"] = Curse_Item_Mod.IRoom["GetHitNum"] + 1
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Curse_Item_Mod.IRoom.IncGetHitNum, EntityType.ENTITY_PLAYER)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Curse_Item_Mod.IRoom.RefreshGetHitNum)

return Curse_Item_Mod.IRoom