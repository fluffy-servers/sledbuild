-- todo: make convar
MAX_PROP_RADIUS = 128

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

local allowed_tools = {
    ["weld"] = true,
    ["remover"] = true,
    ["camera"] = true,
    ["colour"] = true,
    ["material"] = true,
    ["trail"] = true,
    ["axis"] = true,
    ["rope"] = true
}

local blacklisted_props = {
    ["models/props_c17/oildrum001_explosive.mdl"] = true,
    ["models/props_junk/propane_tank001a.mdl"] = true
}

-- Only allow whitelisted tools
function GM:CanTool(ply, trace, tool)
    -- TODO: Restrict tools on anything except our own entities
    if not allowed_tools[tool] then
        ply:ChatPrint("That tool is not allowed")
        sound.Play("HL1/fvox/beep.wav", ply:GetPos(), 75, 80, 130)
        return false
        end
    if allowed_tools[tool] then
    return true
    end
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
    if prop:BoundingRadius() > MAX_PROP_RADIUS then
        prop:Remove()
        ply:ChatPrint("That prop is too large!")
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