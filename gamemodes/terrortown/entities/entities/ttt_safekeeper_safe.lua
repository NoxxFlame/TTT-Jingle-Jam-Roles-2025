if SERVER then
    AddCSLuaFile()
end

local ents = ents
local math = math
local table = table

local CreateEntity = ents.Create
local MathRand = math.Rand
local MathRandom = math.random
local MathRound = math.Round

-- State
SAFEKEEPER_SAFE_STATE_IDLE = 0
SAFEKEEPER_SAFE_STATE_PICKING = 1
SAFEKEEPER_SAFE_STATE_OPEN = 2

if CLIENT then
    local hint_params = {usekey = Key("+use", "USE")}

    --ENT.TargetIDHint = function(safe)
    --    local client = LocalPlayer()
    --    if not IsPlayer(client) then return end

    --    local name
    --    if not IsValid(safe) or safe:GetPlacer() ~= client then
    --        name = LANG.GetTranslation("chf_safe_name")
    --    else
    --        name = LANG.GetParamTranslation("chf_safe_name_health", { current = safe:Health(), max = safe:GetMaxHealth() })
    --    end

    --    return {
    --        name = name,
    --        hint = "chf_safe_hint",
    --        fmt  = function(ent, txt)
    --            if not IsValid(safe) then return nil end

    --            local placer = safe:GetPlacer()
    --            if not IsPlayer(placer) then return nil end
    --            if placer ~= client then return nil end

    --            local hint = txt
    --            local state = safe:GetState()
    --            if state == CHEF_SAFE_STATE_COOKING then
    --                local remaining = safe:GetEndTime() - CurTime()
    --                hint_params.time = util.SimpleTime(remaining, "%02i:%02i")
    --                hint = hint .. "_progress"
    --            elseif state >= CHEF_SAFE_STATE_DONE then
    --                local remaining = safe:GetOvercookTime() - CurTime()
    --                hint_params.time = util.SimpleTime(remaining, "%02i:%02i")
    --                hint = hint .. "_retrieve_" .. state
    --            else
    --                hint = hint .. "_start"
    --            end

    --            return LANG.GetParamTranslation(hint, hint_params)
    --        end
    --    }
    --end
    ENT.AutomaticFrameAdvance = true
end

ENT.Type = "anim"

ENT.CanUseKey = true
ENT.SafeModel = "models/sudisteprops/simple_safe.mdl"

local pick_time = CreateConVar("ttt_safekeeper_pick_time", "30", FCVAR_REPLICATED, "How long (in seconds) it takes to pick a safe", 1, 60)

AccessorFuncDT(ENT, "EndTime", "EndTime")
AccessorFuncDT(ENT, "State", "State")
AccessorFuncDT(ENT, "Placer", "Placer")

function ENT:SetupDataTables()
   self:DTVar("Int", 0, "EndTime")
   self:DTVar("Int", 1, "State")
   self:DTVar("Entity", 0, "Placer")
end

function ENT:Initialize()
    self:SetModel(self.SafeModel)

    if SERVER then
        self:PhysicsInit(SOLID_VPHYSICS)
    end
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_BBOX)
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    -- TODO: Set collision bounding box

    local scale = Vector(0.5, 0.5, 0.5)
    for i=0, self:GetBoneCount() - 1 do
        self:ManipulateBoneScale(i, scale)
    end

    if SERVER then
        self:SetUseType(CONTINUOUS_USE)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
        end

        self:WeldToGround(true)
    end
end

function ENT:Think()
    if CLIENT then return end

    local state = self:GetState()
    if state == SAFEKEEPER_SAFE_STATE_IDLE then return end

    --local endTime = self:GetEndTime()
    --if endTime <= CurTime() then
    --    
    --end
end

if SERVER then
    function ENT:Use(activator)
        if not IsPlayer(activator) or not activator:IsActive() then return end

        local placer = self:GetPlacer()
        if not IsPlayer(placer) then return end
        if activator ~= placer then return end

        local state = self:GetState()
        if state == SAFEKEEPER_SAFE_STATE_OPEN then return end

        -- TODO
    end

    -- Copied from C4
    function ENT:WeldToGround(state)
        if state then
           -- getgroundentity does not work for non-players
           -- so sweep ent downward to find what we're lying on
           local ignore = player.GetAll()
           table.insert(ignore, self)

           local tr = util.TraceEntity({ start = self:GetPos(), endpos = self:GetPos() - Vector(0, 0, 16), filter = ignore, mask = MASK_SOLID }, self)

           -- Start by increasing weight/making uncarryable
           local phys = self:GetPhysicsObject()
           if IsValid(phys) then
              -- Could just use a pickup flag for this. However, then it's easier to
              -- push it around.
              self.OrigMass = phys:GetMass()
              phys:SetMass(150)
           end

           if tr.Hit and (IsValid(tr.Entity) or tr.HitWorld) then
              -- "Attach" to a brush if possible
              if IsValid(phys) and tr.HitWorld then
                 phys:EnableMotion(false)
              end

              -- Else weld to objects we cannot pick up
              local entphys = tr.Entity:GetPhysicsObject()
              if IsValid(entphys) and entphys:GetMass() > CARRY_WEIGHT_LIMIT then
                 constraint.Weld(self, tr.Entity, 0, 0, 0, true)
              end

              -- Worst case, we are still uncarryable
           end
        else
           constraint.RemoveConstraints(self, "Weld")
           local phys = self:GetPhysicsObject()
           if IsValid(phys) then
              phys:EnableMotion(true)
              phys:SetMass(self.OrigMass or 10)
           end
        end
     end
end