
local ROLE = {}

ROLE.nameraw = "safekeeper"
ROLE.name = "Safekeeper"
ROLE.nameplural = "Safekeepers"
ROLE.nameext = "a Safekeeper"
ROLE.nameshort = "sfk"

ROLE.desc = [[You are {role}!
]]
ROLE.shortdesc = ""

ROLE.team = ROLE_TEAM_INDEPENDENT

ROLE.convars =
{
}

ROLE.translations = {
    ["english"] = {
        ["sfk_safe_help_pri"] = "Use {primaryfire} to drop your Safe on the ground"
    }
}

ROLE.haspassivewin = true

RegisterRole(ROLE)

