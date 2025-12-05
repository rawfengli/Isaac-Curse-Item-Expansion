Curse_Item_Mod.Lib = {}

local function IncludeSubLib(key, path)
    Curse_Item_Mod.Lib[key] = require("sprites.commons.lib."..path)
end

IncludeSubLib("Tears", "tears")




