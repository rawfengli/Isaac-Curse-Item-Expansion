Curse_Item_Mod = RegisterMod("Isaac-Curse-Item-Expansion", 1)

--加载lib等文件
local function IncludeFile(filePath)
    require(filePath)
end

IncludeFile("ci_sprites.callback")
IncludeFile("ci_sprites.lib")
IncludeFile("ci_sprites.room")
IncludeFile("ci_sprites.item")
IncludeFile("ci_sprites.transformation")