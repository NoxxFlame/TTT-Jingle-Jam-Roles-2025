local file = file
local ipairs = ipairs
local table = table

local FileFind = file.Find
local TableHasValue = table.HasValue

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
        ["gamer_rarity_common"] = "Common",
        ["gamer_rarity_uncommon"] = "Uncommon",
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
    Common = 1,
    Uncommon = 2,
    Rare = 3,
    Epic = 4,
    Legendary = 5
}
GAMER.Config = GAMER.Config or {
    Rarities = {
        [GAMER.Rarities.Common] = { Name = "gamer_rarity_common", Color = Color(166, 166, 166) },
        [GAMER.Rarities.Uncommon] = { Name = "gamer_rarity_uncommon", Color = Color(0, 182, 33) },
        [GAMER.Rarities.Rare] = { Name = "gamer_rarity_rare", Color = Color(0, 146, 240) },
        [GAMER.Rarities.Epic] = { Name = "gamer_rarity_epic", Color = Color(143, 21, 185) },
        [GAMER.Rarities.Legendary] = { Name = "gamer_rarity_legendary", Color = Color(255, 192, 0) }
    }
    -- TODO: Timing?
}
GAMER.Prizes = GAMER.Prizes or {}

function GAMER.AddPrize(prize)
    if GAMER.Prizes[prize.Id] then return end

    if type(prize.Rarity) ~= "number" or not TableHasValue(GAMER.Rarities, prize.Rarity) then
        ErrorNoHaltWithStack("Invalid rarity ('" .. prize.Rarity .. "') for prize with ID: " .. prize.Id)
        return
    end

    GAMER.Prizes[prize.Id] = prize
end

local files, _ = FileFind("customroles/gamer/prizes/*.lua", "LUA")
for _, fil in ipairs(files) do
    if SERVER then
        AddCSLuaFile("customroles/gamer/prizes/" .. fil)
    end
    include("customroles/gamer/prizes/" .. fil)
end