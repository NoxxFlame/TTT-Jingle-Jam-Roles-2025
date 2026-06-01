local PRIZE = {
    Id = "jump_uncommon",
    Name = "gamer_prize_jump_name",
    NameParams = { amt = "Triple" },
    Description = "gamer_prize_jump_desc",
    DescriptionParams = { amt = "3x" },
    Rarity = GAMER.Rarities.Uncommon,
    Icon = Material("vgui/ttt/gamer/prizes/jump.png")
}

function PRIZE:Start(ply)
    if CLIENT then return end
    if ply.SetMaxJumpLevel then
        ply:SetMaxJumpLevel(ply:GetMaxJumpLevel() + 1)
    else
        ply:SetJumpPower(ply:GetJumpPower() + (GAMER.Config.JumpPower * 2))
    end
end

function PRIZE:End(ply)
    -- No need to undo Triple Jump because it's already done in the server-side role cleanup
end

GAMER.AddPrize(PRIZE)