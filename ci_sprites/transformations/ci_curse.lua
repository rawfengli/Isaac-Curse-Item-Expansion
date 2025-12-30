
local Curse = {}

do
    Curse.PasstiveCollectibles = {
        Curse_Item_Mod.Item["Blind Curse"],
        Curse_Item_Mod.Item["Unknown Curse"],
        Curse_Item_Mod.Item["Lost Curse"],
    }  

    Curse.ActiveCollectibles = {
        Curse_Item_Mod.Item["Maze Curse"],
    }

    Curse.ActiveCollectiblesFlag = {}
    Curse.ActiveCollectiblesFlag[Curse_Item_Mod.Item["Maze Curse"]] = false
end

do--function    
    local flag = false -- 用来标记player是否已经激活套装效果
    function Curse:Init()
        for key, value in pairs(Curse.ActiveCollectibles) do
            Curse.ActiveCollectiblesFlag[key] = false
        end
    end
    function Curse:PlayerFromUpdate()
        local player = Isaac.GetPlayer(0)
        local count = 0
        --passtive
        for index, CollectibleID in ipairs(Curse.PasstiveCollectibles) do
            if player:HasCollectible(CollectibleID) then
                count = count + player:GetCollectibleNum(CollectibleID)
            end
        end
        --active
        for index, CollectibleID in ipairs(Curse.ActiveCollectibles) do
            if player:HasCollectible(CollectibleID) then
                Curse.ActiveCollectiblesFlag[CollectibleID] = true
            end
        end

        for key, value in pairs(Curse.ActiveCollectiblesFlag) do
            if Curse.ActiveCollectiblesFlag[key] then
                count = count + 1
            end
        end

        if count >= 3 and not flag then
            flag = true

            Game():GetHUD():ShowItemText("The Curse!")
            SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER, 5)
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, player.Position, Vector(0, 0), nil)

            --player:AddPlayerFormCostume(PlayerForm.PLAYERFORM_GUPPY) 测试
        end
    end 

    function Curse:LostTransformation()
        local player = Isaac.GetPlayer(0)
        local count = 0

        --passtive
        for index, CollectibleID in ipairs(Curse.PasstiveCollectibles) do
            if player:HasCollectible(CollectibleID) then
                count = count + player:GetCollectibleNum(CollectibleID)
            end
        end
        --active
        for index, CollectibleID in ipairs(Curse.ActiveCollectibles) do
            if player:HasCollectible(CollectibleID) then
                Curse.ActiveCollectiblesFlag[CollectibleID] = true
            end
        end
        for key, value in pairs(Curse.ActiveCollectiblesFlag) do
            if Curse.ActiveCollectiblesFlag[key] then
                count = count + 1
            end
        end

        if count < 3 then
            flag = false

            --player:TryRemoveNullCostume(NullItemID.ID_GUPPY) 测试
        end
    end
    
    function Curse:TransformationEffect()
        local player = Isaac.GetPlayer(0)
        if flag then
            player:AddCard(Card.RUNE_DAGAZ)
        end
    end

    function Curse:UseGenesis(__, __, player)
        print("!!")
        Curse:Init()
    end
end

Curse_Item_Mod:CI_AddCallback(Curse_Item_Mod.CallbackID.GET_ITEM, Curse.PlayerFromUpdate)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Curse.LostTransformation)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Curse.TransformationEffect)
Curse_Item_Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Curse.UseGenesis, CollectibleType.COLLECTIBLE_GENESIS)
