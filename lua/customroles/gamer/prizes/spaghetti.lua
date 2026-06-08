local PRIZE = {
    Id = "spaghetti",
    Name = "item_gamer_spaghetti",
    Description = "item_gamer_spaghetti_desc",
    Rarity = GAMER.Rarities.Rare,
    Icon = Material("vgui/ttt/gamer/prizes/spaghetti.png")
}

function PRIZE:Start(ply)
    if SERVER then
        ply:GiveEquipmentItem(EQUIP_GAMER_SPAGHETTI)
        hook.Run("TTTOrderedEquipment", ply, EQUIP_GAMER_SPAGHETTI, EQUIP_GAMER_SPAGHETTI)
    end
end

function PRIZE:CanStart(ply)
    if ply:HasEquipmentItem(EQUIP_GAMER_SPAGHETTI) then return false end

    -- This is a shop item so only allow it of gacha only mode is enabled
    return GetConVar("ttt_gamer_gacha_only_mode"):GetBool()
end

GAMER.AddPrize(PRIZE)