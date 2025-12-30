local Damage = {}

--受限于技术原因 死眼 八面骰 做不了 
--目前还没有做魅魔和天秤的修正
--伤害乘区
local damageMultipliers = {
    --大眼兼容
    function (d, player)
        local res = d

        local bitnum = 0

        local Polyphemus_Bit = 1 << 0
        local Inner_Eye_Bit = 1 << 1
        local Mutant_Spider_Bit = 1 << 2
        local _2020_Bit = 1 << 3
        local C_Section_Bit = 1 << 4

        if player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS) then--大眼
            bitnum = bitnum + Polyphemus_Bit
        end
        if player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE) then--内眼
            bitnum = bitnum + Inner_Eye_Bit
        end
        if player:HasCollectible(CollectibleType.COLLECTIBLE_MUTANT_SPIDER) then--四眼
            bitnum = bitnum + Mutant_Spider_Bit
        end
        if player:HasCollectible(CollectibleType.COLLECTIBLE_20_20) then--2020
            bitnum = bitnum + _2020_Bit
        end
        if player:HasWeaponType(WeaponType.WEAPON_FETUS) then--刨腹产
            bitnum = bitnum + C_Section_Bit
        end

        local Adjustment_Polyphemus = 2

        if bitnum & Polyphemus_Bit == Polyphemus_Bit then
            if bitnum ^ Polyphemus_Bit ~= 0 then--若有大眼且后四项不满足
                res = res * Adjustment_Polyphemus
            end
        end

        return res
    end,
    --角色倍率(尽管wiki中没有显式的写出，但经过测试角色伤害倍率应该在大眼修正之后的第一个)
    function (d, player)
        local res = d
        local playerType = player:GetPlayerType()
        local effects = player:GetEffects()
        if playerType == PlayerType.PLAYER_EVE then
            if player:GetHearts() <= 2 then
                res = res * 1 
            else
                res = res * 0.75
            end
        end

        return res

    end,
    -- 大蘑菇
    function (d, player)
        local res = d
        local effecs = player:GetEffects()
        local Adjustment_Mege_Mush = 4
        if effecs:HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) then
            res = res * Adjustment_Mege_Mush
        end
        return res
    end,
    --蓝皇冠
    function (d, player)
        local res = d
        local Adjustment_Crown_Of_Light = 2
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) then
            if  player:GetMaxHearts() == player:GetHearts() and
                Curse_Item_Mod.IRoom["GetHitNum"] == 0
            then
                res = res * Adjustment_Crown_Of_Light
            end
        end
        return res
    end,
    --圣心
    function (d, player)
        local res = d
        local Adjustment_Sacred_Heart = 2.3
        if player:HasCollectible(CollectibleType.COLLECTIBLE_SACRED_HEART) then
            res = res * Adjustment_Sacred_Heart
        end
        return res
    end,
    --达摩和彼列之书
    function (d ,player)
        local res = d
        if player:GetPlayerType() == PlayerType.PLAYER_JUDAS then
            if  player:HasCollectible(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE) and
                player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
            
                res = res * 1.4

            end
        end
        return res
    end,
    -- 小圣心
    function (d, player)
        local res = d

        local Adjustment_Immaculate_Heart= 1.2
        if player:HasCollectible(CollectibleType.COLLECTIBLE_IMMACULATE_HEART) then
            res = res * Adjustment_Immaculate_Heart             
        end

        return res
    end,
    --如果阿撒泻勒（人物为阿撒泻勒阿撒泻勒或堕化阿撒泻勒堕化阿撒泻勒，或者 阿撒泻勒的残角生效时）没有 硫磺火：
    function (d, player)
        local res = d
    
        if (player:GetPlayerType() == PlayerType.PLAYER_AZAZEL or 
            player:GetPlayerType() == PlayerType.PLAYER_AZAZEL_B or
            player:GetEffects():HasTrinketEffect(TrinketType.TRINKET_AZAZELS_STUMP)) and
            player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) ~= true
        then
            --如果攻击方式为硫磺火，且拥有 悬浮科技
            if  player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) and 
                player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) 
            then 
               res = res * 0.5 
            end

            --否则如果攻击方式为科技X
            if player:HasWeaponType(WeaponType.WEAPON_TECH_X) then
                res = res * 0.65
            end
        end 
        return res
    end,
    --多个硫磺火
    function (d, player)
        local res = d
        local Brimstone_Num = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BRIMSTONE)
        local Adjustment_Multiple_Brimstone = 1.2
        if player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) then
            if Brimstone_Num >= 2 then
                res = res * Adjustment_Multiple_Brimstone
            end 
        end
        return res
    end,
    --如果攻击方式为硫磺火，且拥有 科技，但没有2个及以上的 硫磺火
    function (d, player)
        local res = d
        local Brimstone_Num = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BRIMSTONE)
        local Adjustment_Signle_Brimstone = 1.5
        if  player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) and 
            player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) and Brimstone_Num <= 1 then
            
            res = res * Adjustment_Signle_Brimstone
        end
        return res
    end,
    --如果攻击方式为科技X，且拥有 科技和 硫磺火
    function (d, player)
        local res = d
        if  player:HasWeaponType(WeaponType.WEAPON_TECH_X) and 
            player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) and
            player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then
    
            res = res * 1.5
        end
        return res
    end,
    --血泪
    function (d, player)
        local res = d
        local Adjustment_Haemolacria = 1.5
        if player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) then
            res = res * 1.5             
        end
        return res
    end,
    --狗头 or 大蘑菇 or 殉道者之血+彼列之书：
    function (d, player)
        local res = d
        local flag = 0
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CRICKETS_HEAD) then--狗头
            flag = flag | 1
        end
        if player:HasCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM) then--大蘑菇
            flag = flag | 1
        end
        if  player:HasCollectible(CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR) and 
            player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL) then--殉道者之血+彼列之书
            flag = flag | 1
        end
        if flag == 1 then
            res = res * 1.5
        end 
        return res
    end,
    --睫毛膏
    function (d, player)
        local res = d
        if player:HasCollectible(CollectibleType.COLLECTIBLE_EVES_MASCARA) then
            res = res * 2
        end 
        return res
    end,
    --杏仁奶与豆奶
    function (d, player)
        local res = d
        if player:HasCollectible(CollectibleType.COLLECTIBLE_ALMOND_MILK) then
            res = res * 0.3
        else
            if player:HasCollectible(CollectibleType.COLLECTIBLE_SOY_MILK) then
                res = res * 0.2
            end
        end
        return res
    end,
    function (d, player)
        local res = d
        if player:HasCollectible(CollectibleType.COLLECTIBLE_20_20) then
            res = res * 0.8
        end
        return res
    end,
    
}

function Damage:ModifyDirectDamage(d, player)
    local res = d
    for __, func in ipairs(damageMultipliers) do
        res = func(res, player)
    end
    return res
end 

return Damage