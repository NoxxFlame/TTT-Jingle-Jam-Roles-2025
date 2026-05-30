local ROLE = {}

ROLE.nameraw = "gamer"
ROLE.name = "Gamer"
ROLE.nameplural = "Gamers"
ROLE.nameext = "a Gamer"
ROLE.nameshort = "gmr"

ROLE.desc = [[]]
ROLE.shortdesc = ""

ROLE.team = ROLE_TEAM_DETECTIVE


ROLE.translations = {
    ["english"] = {
        ["gamer_rarity_uncommon"] = "Uncommon",
        ["gamer_rarity_common"] = "Common",
        ["gamer_rarity_rare"] = "Rare",
        ["gamer_rarity_epic"] = "Epic",
        ["gamer_rarity_legendary"] = "Legendary",
        ["gamer_prize_display_format"] = "{name} [{rarity}]",
        ["gamer_prize_doritos_name"] = "Doritos",
        ["gamer_prize_doritos_desc"] = "Get two free gacha rolls"
    }
}

RegisterRole(ROLE)

GAMER = GAMER or {}
GAMER.Rarities = GAMER.Rarities or {
    Uncommon = 1,
    Common = 2,
    Rare = 3,
    Epic = 4,
    Legendary = 5
}
GAMER.Config = GAMER.Config or {
    Rarities = {
        [GAMER.Rarities.Uncommon] = { name = "gamer_rarity_uncommon", color = Color(166, 166, 166) },
        [GAMER.Rarities.Common] = { name = "gamer_rarity_common", color = Color(0, 182, 33) },
        [GAMER.Rarities.Rare] = { name = "gamer_rarity_rare", color = Color(0, 146, 240) },
        [GAMER.Rarities.Epic] = { name = "gamer_rarity_epic", color = Color(143, 21, 185) },
        [GAMER.Rarities.Legendary] = { name = "gamer_rarity_legendary", color = Color(255, 192, 0) }
    }
    -- TODO: Timing?
}
GAMER.Prizes = GAMER.Prizes or {
    {
        name = "gamer_prize_doritos_name",
        description = "gamer_prize_doritos_desc",
        rarity = GAMER.Rarities.Legendary
    }
}

function GAMER.AddPrize(id, prize)
    if GAMER.Prizes[id] then
        ErrorNoHaltWithStack("A prize with the given id ('" .. id .. "') already exists")
        return
    end

    if type(prize.rarity) ~= "number" or not table.HasValue(GAMER.Rarities, prize.rarity) then
        ErrorNoHaltWithStack("Invalid rarity ('" .. prize.rarity .. "') for prize with ID: " .. id)
        return
    end

    GAMER.Prizes[id] = prize
end
