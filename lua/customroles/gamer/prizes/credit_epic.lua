local PRIZE = {
    Id = "credit_epic",
    Name = "gamer_prize_credit_name",
    Description = "gamer_prize_credit_desc",
    Rarity = GAMER.Rarities.Epic,
    Icon = Material("vgui/ttt/gamer/prizes/credit.png"),
    SillyName = "gamer_prize_token",
    SillyIcon = Material("vgui/ttt/gamer/prizes/token.png")
}

function PRIZE:Start(ply)
    if CLIENT then return end
    ply:AddCredits(1)
end

function PRIZE:CanStart(ply)
    -- If gacha only mode is enabled a credit is the cost for a gacha roll so this prize just does nothing
    return not GetConVar("ttt_gamer_gacha_only_mode"):GetBool()
end

GAMER.AddPrize(PRIZE)