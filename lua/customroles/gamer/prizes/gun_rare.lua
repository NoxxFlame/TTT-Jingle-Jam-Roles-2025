local PRIZE = {
    Id = "gun_rare",
    Name = "gamer_prize_gun_name",
    Description = "gamer_prize_gun_desc",
    Rarity = GAMER.Rarities.Rare,
    Icon = Material("vgui/ttt/gamer/prizes/gun.png"),
    SillyIcon = Material("vgui/ttt/gamer/prizes/lmaobang.png")
}

local function GetWeaponId()
    local weaponIds = {"weapon_sp_dbarrel", "weapon_m9k_dbarrel" }
    if cvars.Bool("ttt_tweaks_cr_m9k_dbarrel", false) then
        table.insert(weaponIds, "weapon_cr_m9k_dbarrel")
    end

    for _, weaponId in ipairs(weaponIds) do
        if weapons.Get(weaponId) ~= nil then
            return weaponId
        end
    end
    return nil
end

function PRIZE:Start(ply)
    if CLIENT then return end

    local weaponId = GetWeaponId()
    local storedWeap = weapons.Get(weaponId)
    local weaponData = { }
    if not ply:CanCarryWeapon(storedWeap) then
        for _, weap in ipairs(ply:GetWeapons()) do
            if weap.Kind == storedWeap.Kind then
                weaponData.Weapon = weap
                weaponData.Kind = weap.Kind
                weap.Kind = 100
                break
            end
        end
    end

    local given = ply:Give(weaponId)
    if IsValid(given) then
        given.Kind = 99
        if IsValid(weaponData.Weapon) then
            weaponData.Weapon.Kind = weaponData.Kind
        end
        TTTPAP:ApplyRandomUpgrade(given)
    end
end

function PRIZE:CanStart(ply)
    if TTTPAP and GetWeaponId() ~= nil then return true end
    return false
end

GAMER.AddPrize(PRIZE)