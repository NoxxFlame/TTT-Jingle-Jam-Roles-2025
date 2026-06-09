local PRIZE = {
    Id = "mtdew",
    Name = "item_gamer_mtdew",
    Description = "item_gamer_mtdew_desc",
    Rarity = GAMER.Rarities.Rare,
    Icon = Material("vgui/ttt/gamer/prizes/mtdew.png")
}

function PRIZE:Start(ply)
    if SERVER then
        ply:GiveEquipmentItem(EQUIP_GAMER_MTDEW)
        hook.Run("TTTOrderedEquipment", ply, EQUIP_GAMER_MTDEW, EQUIP_GAMER_MTDEW)
    end
end

function PRIZE:CanStart(ply)
    if ply:HasEquipmentItem(EQUIP_GAMER_MTDEW) then return false end

    -- This is a shop item so only allow it of gacha only mode is enabled
    return GetConVar("ttt_gamer_gacha_only_mode"):GetBool()
end

GAMER.AddPrize(PRIZE)