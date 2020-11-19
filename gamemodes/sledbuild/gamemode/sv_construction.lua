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

function GM:CanTool(ply, trace, mode)
    -- TODO: Restrict tools on anything except our own entities
    -- TODO: Restrict most tool types
    return true
end

function GM:PlayerSpawnProp(ply, model)
    -- TODO: Prop blacklisting
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