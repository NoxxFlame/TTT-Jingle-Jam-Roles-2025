local PRIZE = {
    Id = "cheetos",
    Name = "item_gamer_cheetos",
    Description = "item_gamer_cheetos_desc",
    Rarity = GAMER.Rarities.Epic,
    Icon = Material("vgui/ttt/gamer/prizes/cheetos.png")
}

function PRIZE:Start(ply)
    if SERVER then
        ply:GiveEquipmentItem(EQUIP_GAMER_CHEETOS)
        hook.Run("TTTOrderedEquipment", ply, EQUIP_GAMER_CHEETOS, EQUIP_GAMER_CHEETOS)
    end
end

function PRIZE:CanStart(ply)
    if ply:HasEquipmentItem(EQUIP_GAMER_CHEETOS) then return false end

    -- This is a shop item so only allow it of gacha only mode is enabled
    return GetConVar("ttt_gamer_gacha_only_mode"):GetBool()
end

GAMER.AddPrize(PRIZE)