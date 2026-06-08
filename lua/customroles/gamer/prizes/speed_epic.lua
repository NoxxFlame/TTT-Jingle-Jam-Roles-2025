local table = table

local TableInsert = table.insert

local PRIZE = {
    Id = "speed_epic",
    Name = "gamer_prize_speed_name",
    Description = "gamer_prize_speed_desc",
    DescriptionParams = { amt = 40 },
    Rarity = GAMER.Rarities.Epic,
    Icon = Material("vgui/ttt/gamer/prizes/speed.png")
}

function PRIZE:Start(ply)
    hook.Add("TTTSpeedMultiplier", "Gamer_TTTSpeedMultiplier_Epic_" .. ply:SteamID64(), function(p, mults)
        if not IsPlayer(ply) then return end
        if ply ~= p then return end
        TableInsert(mults, 1.4)
    end)
end

function PRIZE:End(ply)
    hook.Remove("TTTSpeedMultiplier", "Gamer_TTTSpeedMultiplier_Epic_" .. ply:SteamID64())
end

GAMER.AddPrize(PRIZE)