local PRIZE = {
    Id = "doritos",
    Name = "item_gamer_doritos",
    Description = "item_gamer_doritos_desc",
    Rarity = GAMER.Rarities.Rare,
    Icon = Material("vgui/ttt/gamer/prizes/doritos.png")
}

function PRIZE:Start(ply)
    if SERVER then
        ply:GiveEquipmentItem(EQUIP_GAMER_DORITOS)
        hook.Run("TTTOrderedEquipment", ply, EQUIP_GAMER_DORITOS, EQUIP_GAMER_DORITOS)
    end
end

function PRIZE:CanStart(ply)
    if ply:HasEquipmentItem(EQUIP_GAMER_DORITOS) then return false end

    -- This is a shop item so only allow it of gacha only mode is enabled
    return GetConVar("ttt_gamer_gacha_only_mode"):GetBool()
end

GAMER.AddPrize(PRIZE)