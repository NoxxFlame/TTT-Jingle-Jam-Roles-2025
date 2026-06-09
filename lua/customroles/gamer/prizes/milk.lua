local PRIZE = {
    Id = "milk",
    Name = "item_gamer_milk",
    Description = "item_gamer_milk_desc",
    Rarity = GAMER.Rarities.Epic,
    Icon = Material("vgui/ttt/gamer/prizes/milk.png")
}

function PRIZE:Start(ply)
    if SERVER then
        ply:GiveEquipmentItem(EQUIP_GAMER_MILK)
        hook.Run("TTTOrderedEquipment", ply, EQUIP_GAMER_MILK, EQUIP_GAMER_MILK)
    end
end

function PRIZE:CanStart(ply)
    if ply:HasEquipmentItem(EQUIP_GAMER_MILK) then return false end

    -- This is a shop item so only allow it of gacha only mode is enabled
    return GetConVar("ttt_gamer_gacha_only_mode"):GetBool()
end

GAMER.AddPrize(PRIZE)