-- Allowed vehicle types
local allowed_vehicles = {
    ["Chair_Office1"] = true,
    ["Chair_Plastic"] = true,
    ["Chair_Wood"] = true,
    ["Chair_Office2"] = true,
    ["Pod"] = true,
    ["Seat_Airboat"] = true,
    ["Seat_Jeep"] = true
}

local blacklisted_props = {
    ["models/props_c17/oildrum001_explosive.mdl"] = true,
    ["models/props_junk/propane_tank001a.mdl"] = true
}

-- Only allow whitelisted tools
function GM:CanTool(ply, trace, tool)
    -- TODO: Restrict tools on anything except our own entities
    if not GAMEMODE.AllowedTools[tool] then
        ply:ChatPrint("That tool is not allowed")
        sound.Play("HL1/fvox/beep.wav", ply:GetPos(), 75, 80, 130)
        return false
        end
    return true
end

-- Don't allow blacklisted props
function GM:PlayerSpawnProp(ply, model)
    if blacklisted_props[model] then
        ply:ChatPrint("That prop is blacklisted!")
        sound.Play("HL1/fvox/beep.wav", ply:GetPos(), 75, 80, 130)
        return false
    end

    if ply:GetNWBool("Racing") then
        return false
    end
    return true
end

function GM:PlayerSpawnedProp(ply, model, prop)
    local max_radius = GetConVar("slb_max_prop_radius"):GetInt()
    if prop:BoundingRadius() > max_radius then
        prop:Remove()
        ply:ChatPrint("That prop is too large!")
        sound.Play("HL1/fvox/beep.wav", ply:GetPos(), 75, 80, 130)
        return
    end

    prop:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
    return true
end

-- Only allow very specific vehicle types
function GM:PlayerSpawnVehicle(ply, model, name)
    if not allowed_vehicles[name] then
        ply:ChatPrint("That vehicle is not allowed - try a chair")
        sound.Play("HL1/fvox/beep.wav", ply:GetPos(), 75, 80, 130)
        return false
    end

    return true
end

function GM:PlayerSpawnedVehicle(ply, ent)
    ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
    return true
end

-- Disable spawning ragdolls
function GM:PlayerSpawnRagdoll()
    return false
end

-- Disable spawning effects
function GM:PlayerSpawnEffect()
    return false
end

-- Disable spawning NPCs
function GM:PlayerSpawnNPC()
    return false
end

-- Disable spawning entities
function GM:PlayerSpawnSENT()
    return false
end

-- Disable spawning weapons
function GM:PlayerSpawnSWEP()
    return false
end

-- Disable giving weapons
function GM:PlayerGiveSWEP()
    return false
end