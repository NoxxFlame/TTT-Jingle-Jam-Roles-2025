local hook = hook
local util = util

local AddHook = hook.Add

util.AddNetworkString("TTTGamerGachaStart")

AddHook("TTTOrderedEquipment", function(ply, id, isequip)
    if id == EQUIP_GAMER_DORITOS then
        -- If the player doesn't have the gacha roller already, give it to them
        local gacha = ply:GetWeapon("weapon_gmr_gacha") or ply:Give("weapon_gmr_gacha")
        -- And give it some ammo
        if IsValid(gacha) then
            gacha:SetClip1(gacha:Clip1() + 2)
        end
    elseif id == EQUIP_GAMER_MTDEW then
        -- TODO: 20% speed increase and triple jump
    elseif id == EQUIP_GAMER_CHEETOS then
        -- Heal the player to max
        local hp = ply:Health()
        local max = ply:GetMaxHealth()
        if hp < max then
            ply:SetHealth(max)
        end

        -- If the player doesn't have the cheeto fingers already, give it to them
        local fingers = ply:GetWeapon("weapon_gmr_cheeto_fingers") or ply:Give("weapon_gmr_cheeto_fingers")
        -- And give it some ammo
        if IsValid(fingers) then
            fingers:SetClip1(fingers:Clip1() + 1)
        end
    elseif id == EQUIP_GAMER_SPAGHETTI then
        -- TODO: Provides 5% health regen per second (unsure if permanent or not)
    elseif id == EQUIP_GAMER_MILK then
        -- TODO: ??
    end
end)