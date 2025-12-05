local Tears = {}

local damageMultiplier = {
    -- 眼药水
    function (t, player)
        local res = t
        if player:HasCollectible(CollectibleType.COLLECTIBLE_EYE_DROPS) then
            res = res * 1.2
        end
        return res
    end,
    -- 2020 与 大眼四眼内眼
    function (t, player)
        local res = t
        if player:HasCollectible(EntityType.ENTITY_POOP) then
            return res
        end
        local bitnum = 0
        local Inner_Eye_bit = 1 << 0
        local Mutant_Spider_bit = 1 << 1
        local Polyphemus_bit = 1 << 2

        local Adjustment_Inner_Eye = 0.51
        local Adjustment_Not_Inner_Eye = 0.42

        if player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE) then
            bitnum = bitnum + Inner_Eye_bit      
        end
        if player:HasCollectible(CollectibleType.COLLECTIBLE_MUTANT_SPIDER) then
            bitnum = bitnum + Mutant_Spider_bit           
        end
        if player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS) then
            bitnum = bitnum + Polyphemus_bit         
        end
        if player:HasCollectible(CollectibleType.COLLECTIBLE_C_SECTION) ~= true then
            if bitnum > 0 then -- 有三个道具中的一个
                if bitnum == Inner_Eye_bit then -- 只有内眼
                    res = res * Adjustment_Inner_Eye
                else
                    res = res * Adjustment_Not_Inner_Eye -- 无内眼 或 有内眼同有四眼或大眼
                end 
            end 
        end

        return res
    end,
    --土根
    function (t, player)
        local res = t
        local Adjustment_Ipecac = 1 / 3
        if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then

            if  player:HasWeaponType(WeaponType.WEAPON_TEARS) or 
                player:HasWeaponType(WeaponType.WEAPON_LASER) or
                player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
                    res = res * Adjustment_Ipecac
            end
        end
        return res
    end,
    --血泪兼容
    function (t, player)
        local res = t 

        local Haemolacria = CollectibleType.COLLECTIBLE_HAEMOLACRIA -- 血泪
        local Ipecac = CollectibleType.COLLECTIBLE_IPECAC -- 土根
        local Brimstone = CollectibleType.COLLECTIBLE_BRIMSTONE --硫磺火
        local DR_Fetus = CollectibleType.COLLECTIBLE_DR_FETUS --胎儿博士
        local Monstros_Lung = CollectibleType.COLLECTIBLE_MONSTROS_LUNG -- 萌肺
        --道具位掩码
        local Haemolacria_Bit = 1 << 0
        local Ipecac_Bit = 1 << 1
        local Brimstone_Bit = 1 << 2
        local DR_Fetus_Bit = 1 << 3
        local Monstros_Lung = 1 << 4

        local item_Bit = 0
        if player:HasCollectible(Haemolacria) then
            item_Bit = item_Bit + Haemolacria_Bit        
        end

        if player:HasCollectible(Ipecac) then
            item_Bit = item_Bit + Ipecac_Bit        
        end

        if player:HasCollectible(Brimstone) then
            item_Bit = item_Bit + Brimstone_Bit        
        end

        if player:HasCollectible(DR_Fetus) then
            item_Bit = item_Bit + DR_Fetus_Bit        
        end


        --在有血泪的情况下
        if item_Bit & Haemolacria_Bit ~= 0 then
            local a, b, c
            -- a参数
            if player:HasWeaponType(WeaponType.WEAPON_TEARS) and (item_Bit & Ipecac_Bit) ~= 0 then
                a = 2
            else
                a = 1
            end
            -- b参数
            if player:HasWeaponType(WeaponType.WEAPON_FETUS) then
                b = 4
            else 
                b = 10
            end
            -- c参数
            c = 0
            if player:HasCollectible(Brimstone) then
                c = 20
            else 
                if player:HasCollectible(DR_Fetus) then
                    c = 10
                end
            end
            if player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
                c = c / 2
            end

            res = res * 30 / (30*a + (b+c)*res) 
        end
        return res
    end,
    -- 攻击方式为硫磺火
    function (t, player)
        local res = t
        local Adjustment_Brimstone = 1 / 3
        if player:HasWeaponType(WeaponType.WEAPON_BRIMSTONE) then
            res = res * Adjustment_Brimstone
        end
        return res
    end,
    -- 攻击方式为胎儿
    function (t, player)
        local res = t
        local Adjustment_DR_Fetus = 0.4
        if player:HasWeaponType(WeaponType.WEAPON_BOMBS) then
            res = res * Adjustment_DR_Fetus
        end
        return res
    end,
    -- 攻击为骨头棒槌
    function (t, player)
        local res = t
        local Adjustment_Bone = 0.5
        if player:HasWeaponType(WeaponType.WEAPON_BONE) then
            res = res * Adjustment_Bone
        end
        return res
    end,
    --
--补一个 34修正
    function (t, player)--科技2
        local res = t
        local Adjustment_Technology2 = 2 / 3
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) then
            res = res * Adjustment_Technology2
        end
        return res
    end,
-- 补一个里亚娃
    function (t, player)--睫毛膏
        local res = t
        local Adjustment_Eves_Mascara = 2 / 3
        if player:HasCollectible(CollectibleType.COLLECTIBLE_EVES_MASCARA) then
            res = res * Adjustment_Eves_Mascara
        end
        return res
    end,
    --攻击方式为萌肺
    function (t, player)
        local res = t
        local Adjustment_Lung = 10 / 43
        if player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
            res = res * Adjustment_Lung
        end
        return res
    end
}

function Tears:FromMaxFireDelayToTears(maxFireDelay)-- T = 30/(d+1)
    local dT = 30
    return dT / (maxFireDelay + 1)
end

function Tears:FromTearsToMaxFireDelay(tears)-- d = 30/T - 1
    local dT = 30
    return dT / tears - 1 
end

function Tears:CalculateTears(t, player)--用于计算tear的乘区修正
    local result = t
    for __, func in ipairs(damageMultiplier) do -- 通过已封装好的函数计算t的最终值
        result = func(result, player)
    end
    return result -- return maxfiresdelay
end 

function Tears:ModifyTears(tearsValue, player)-- 计算增加 当addTear = x 后 转换 为 MaxFireDelay 的修正值
    local x = Tears:CalculateTears(tearsValue, player)
    local T = Tears:FromMaxFireDelayToTears(player.MaxFireDelay)
    local incOfMaxFireDelay = - 30 * x/(T*T+T*x)
    return incOfMaxFireDelay
end

function Tears:ModifyMaxFireDelay()
    
end

function Tears:Modifyt()
    
end

return Tears