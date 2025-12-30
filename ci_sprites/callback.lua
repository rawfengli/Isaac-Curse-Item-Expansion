Curse_Item_Mod.CallbackID = {
    GET_ITEM = "GetItem",

}

Curse_Item_Mod.CallbackFunc = {}

function Curse_Item_Mod:CI_AddCallback(callBlackID, func)
    if not Curse_Item_Mod.CallbackFunc[callBlackID] then
        Curse_Item_Mod.CallbackFunc[callBlackID] = {}
    end
    table.insert(Curse_Item_Mod.CallbackFunc[callBlackID], func)
end 

local function Load(path)
    require("ci_sprites.callbacks."..path)
end


Load("get_item")