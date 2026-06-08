local hook = hook

local PRIZE = {
    Id = "shop_legendary",
    Name = "gamer_prize_shop_name",
    Description = "gamer_prize_shop_desc",
    DescriptionParams = function()
        if not TTTPAP then return { extra = "" } end
        return { extra = " and PAPs your active weapon" }
    end,
    Rarity = GAMER.Rarities.Legendary,
    Icon = Material("vgui/ttt/gamer/prizes/shop.png"),
    SillyIcon = Material("vgui/ttt/gamer/prizes/snacks.png")
}

function PRIZE:Start(ply)
    if CLIENT then return end

    for _, item in ipairs({ EQUIP_GAMER_DORITOS, EQUIP_GAMER_MTDEW, EQUIP_GAMER_CHEETOS, EQUIP_GAMER_SPAGHETTI, EQUIP_GAMER_MILK }) do
        if ply:HasEquipmentItem(item) then continue end
        ply:GiveEquipmentItem(item)
        hook.Run("TTTOrderedEquipment", ply, item, item)
    end

    if TTTPAP and ply.GetActiveWeapon then
        local activeWeap = ply:GetActiveWeapon()
        if IsValid(activeWeap) then
            -- If we have the gacha roller out, try to PAP the last weapon instead
            if WEPS.GetClass(activeWeap) == "weapon_gmr_gacha" then
                local prevWeap = ply:GetInternalVariable("m_hLastWeapon")
                if IsValid(prevWeap) and prevWeap ~= NULL then
                    TTTPAP:ApplyRandomUpgrade(prevWeap)
                    return
                end
            end

            TTTPAP:ApplyRandomUpgrade(activeWeap)
        end
    end
end

GAMER.AddPrize(PRIZE)