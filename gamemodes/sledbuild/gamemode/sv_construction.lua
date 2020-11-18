function GM:CanTool(ply, trace, mode)
    -- TODO: Restrict tools on anything except our own entities
    -- TODO: Restrict most tool types
    return true
end

function GM:PlayerSpawnProp(ply, model)
    -- TODO: Prop blacklisting
    -- TODO: Don't spawn props in racing area
    return true
end

function GM:PlayerSpawnedProp(ply, model, prop)
    -- TODO: Remove overly large props
    return true
end

-- Only allow very specific vehicle types
function GM:PlayerSpawnVehicle(ply, model, name)
    if model != "models/vehicles/prisoner_pod_inner.mdl" and model != "models/nova/airboat_seat.mdl" then
        return false
    end

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