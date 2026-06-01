local PRIZE = {
    Id = "credit_epic",
    Name = "gamer_prize_credit_name",
    Description = "gamer_prize_credit_desc",
    Rarity = GAMER.Rarities.Epic,
    Icon = Material("vgui/ttt/gamer/prizes/credit.png")
}

function PRIZE:Start(ply)
    if CLIENT then return end
    ply:AddCredits(1)
end

GAMER.AddPrize(PRIZE)