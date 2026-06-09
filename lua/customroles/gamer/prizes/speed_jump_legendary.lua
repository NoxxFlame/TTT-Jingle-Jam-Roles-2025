local table = table

local TableInsert = table.insert

local PRIZE = {
    Id = "speed_jump_legendary",
    Name = "gamer_prize_speed_jump_name",
    Description = "gamer_prize_speed_jump_desc",
    Rarity = GAMER.Rarities.Legendary,
    Icon = Material("vgui/ttt/gamer/prizes/speed_jump.png"),
    SillyName = "gamer_prize_keyboard_legendary",
    SillyIcon = Material("vgui/ttt/gamer/prizes/keyboard_legendary.png")
}

function PRIZE:Start(ply)
    hook.Add("TTTSpeedMultiplier", "Gamer_TTTSpeedMultiplier_Legendary_" .. ply:SteamID64(), function(p, mults)
        if not IsPlayer(ply) then return end
        if ply ~= p then return end
        TableInsert(mults, 1.5)
    end)

    if SERVER then
        if ply.SetMaxJumpLevel then
            ply:SetMaxJumpLevel(ply:GetMaxJumpLevel() + 2)
        else
            ply:SetJumpPower(ply:GetJumpPower() + (GAMER.Config.JumpPower * 3))
        end
    end
end

function PRIZE:End(ply)
    hook.Remove("TTTSpeedMultiplier", "Gamer_TTTSpeedMultiplier_Legendary_" .. ply:SteamID64())
    -- No need to undo Quad Jump because it's already done in the server-side role cleanup
end

GAMER.AddPrize(PRIZE)