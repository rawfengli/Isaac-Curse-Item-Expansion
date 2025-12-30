local playerItemCount = 0

local function GetItem()

    if not Curse_Item_Mod.CallbackFunc[Curse_Item_Mod.CallbackID.GET_ITEM] then
        Curse_Item_Mod.CallbackFunc[Curse_Item_Mod.CallbackID.GET_ITEM] = {}
    end

    for index, func in ipairs(Curse_Item_Mod.CallbackFunc[Curse_Item_Mod.CallbackID.GET_ITEM]) do
        func()
    end
end

Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function ()
    local player = Isaac.GetPlayer(0)
    local count = player:GetCollectibleCount()
    if count > playerItemCount then
        GetItem()
    end
    playerItemCount = count
end)
