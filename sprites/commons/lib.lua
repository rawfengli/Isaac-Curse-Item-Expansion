Curse_Item_Mod.Lib = {}

local function IncludeSubLib(key, path)
    Curse_Item_Mod.Lib[key] = require("sprites.commons.libs."..path)
end

IncludeSubLib("Tears", "tears")
IncludeSubLib("Damage", "damage")




