Curse_Item_Mod = RegisterMod("Isaac-Curse-Item-Expansion", 1)

--加载lib等文件
local function IncludeFile(filePath)
    require(filePath)
end

IncludeFile("sprites.commons.lib")
IncludeFile("sprites.commons.room")
IncludeFile("sprites.commons.item")
