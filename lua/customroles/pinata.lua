local hook = hook
local player = player
local table = table
local timer = timer
local weapons = weapons

local AddHook = hook.Add
local PlayerIterator = player.Iterator
local TableHasValue = table.HasValue
local TableInsert = table.insert
local WeaponsGetList = weapons.GetList

local ROLE = {}

ROLE.nameraw = "pinata"
ROLE.name = "Pinata"
ROLE.nameplural = "Piñatas"
ROLE.nameext = "a Piñata"
ROLE.nameshort = "pin"

ROLE.desc = [[You are {role}!]]
ROLE.shortdesc = ""

ROLE.team = ROLE_TEAM_INDEPENDENT

ROLE.convars =
{
    {
        cvar = "ttt_pinata_damage_interval",
        type = ROLE_CONVAR_TYPE_NUM,
        decimal = 0
    }
}

RegisterRole(ROLE)
-- Add the accent back after registering the role
timer.Simple(5, function()
    ROLE_STRINGS[ROLE_PINATA] = "Piñata"
end)

------------------
-- ROLE CONVARS --
------------------

local pinata_damage_interval = CreateConVar("ttt_pinata_damage_interval", "20", FCVAR_REPLICATED, "How much damage the piñata must take between weapon drops", 1, 100)

if SERVER then
    -------------------
    -- ROLE FEATURES --
    -------------------

    ROLE_ON_ROLE_ASSIGNED[ROLE_PINATA] = function(ply)
        -- Use a slight delay to make sure nothing else is changing this player's role first
        timer.Simple(0.25, function()
            ply.TTTPinataDamageTaken = 0
        end)
    end

    local function DropWeapon(wep, source_pos)
        local pos = source_pos + Vector(0, 0, 25)
        local ent = CreateEntity(wep)
        ent:SetPos(pos)
        ent:Spawn()

        local phys = ent:GetPhysicsObject()
        if phys:IsValid() then phys:ApplyForceCenter(Vector(math.Rand(-100, 100), math.Rand(-100, 100), 300) * phys:GetMass()) end
    end

    AddHook("PostEntityTakeDamage", "Pinata_PostEntityTakeDamage", function(ent, dmginfo, taken)
        if not taken then return end
        if not IsPlayer(ent) or not ent:IsActivePinata() then return end

        local dmg = dmginfo:GetDamage()
        ent.TTTPinataDamageTaken = ent.TTTPinataDamageTaken + dmg

        local damage_interval = pinata_damage_interval:GetInt()
        if ent.TTTPinataDamageTaken > damage_interval then
            ent.TTTPinataDamageTaken  = ent.TTTPinataDamageTaken - damage_interval

            -- Drop a weapon
            local weps = WeaponsGetList()
            local wep = nil
            for _, v in RandomPairs(weps) do
                if v and not v.AutoSpawnable and v.CanBuy and #v.CanBuy > 0 and v.AllowDrop then
                    wep = WEPS.GetClass(v)
                    break
                end
            end

            -- Sanity check
            if wep then
                local pos = ent:GetPos()
                local ang = ent:GetAngles()
                -- Drop behind the player
                local new_pos = pos - (ang:Forward() * 40)
                DropWeapon(wep, new_pos)
            end
        end

        -- Keep track of which player damaged which piñatas
        local att = dmginfo:GetAttacker()
        if IsPlayer(att) then
            if not att.TTTPinatasDamaged then
                att.TTTPinatasDamaged = {}
            end
            TableInsert(att.TTTPinatasDamaged, ent:SteamID64())
        end
    end)

    -- Block damage from a piñata against a player unless they've damaged that piñata first
    AddHook("EntityTakeDamage", "Pinata_EntityTakeDamage", function(ent, dmginfo)
        if not IsPlayer(ent) then return end
        if not ent.TTTPinatasDamaged then return end

        local att = dmginfo:GetAttacker()
        if not IsPlayer(att) then return end
        if not att:IsActivePinata() then return end

        if TableHasValue(ent.TTTPinatasDamaged, att:SteamID64()) then
            dmginfo:ScaleDamage(0)
        end
    end)

    -------------
    -- CLEANUP --
    -------------

    AddHook("TTTPrepareRound", "Pinata_TTTPrepareRound", function()
        for _, v in PlayerIterator() do
            v.TTTPinataDamageTaken = nil
        end
    end)
end

if CLIENT then
    -- TODO: Target ID text to show players who have damaged the pinata
    -- TODO: Tutorial
end