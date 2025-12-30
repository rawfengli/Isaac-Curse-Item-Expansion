Curse_Item_Mod.Transformations = {
    ci_curse = "curse"
}

local function Load(path)
    require("ci_sprites.transformations."..path)
end
 
Load("ci_curse")
