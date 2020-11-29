function GM:GetNextRaceNumber()
    return GetGlobalInt("NextRace", 1)
end

function GM:UpdateNextRaceNumber()
    SetGlobalInt("NextRace", self:GetNextRaceNumber() + 1)
end

-- Start a new round
function GM:StartRound()
    timer.Stop("SledbuildRoundStart")

    -- Network to clients
    net.Start("SBStartRound")
        net.WriteInt(GAMEMODE:GetNextRaceNumber(), 16)
    net.Broadcast()

    -- Handle round pushing
    GAMEMODE:EnableRoundPush()
    timer.Simple(10, GAMEMODE.DisableRoundPush)

    -- Setup timer to kill the round
    local racetime = GetConVar("slb_race_time"):GetInt() or 60
    if racetime < 10 then racetime = 10 end
    timer.Create("SledbuildRoundEnd", racetime, 1, GAMEMODE.EndRound)
end

function GM:EndRound()
    timer.Stop("SledbuildRoundEnd")

    -- Increment the race number
    GAMEMODE:UpdateNextRaceNumber()
    
    -- Prepare for the next race
    local race_duration = GetConVar("slb_race_time"):GetInt() or 60
    local time_between_races = GetConVar("slb_construction_time"):GetInt() or 120
    local time_til_next_race = time_between_races - race_duration
    if time_til_next_race <= 0 then
        GAMEMODE:StartRound()
    else
        timer.Create("SledbuildRoundStart", time_til_next_race, 1, GAMEMODE.StartRound)
    end
end

-- Enable the "pusher" at the start of a round
function GM:EnableRoundPush()
    for _, v in pairs(ents.FindByName("Pusher")) do
        v:Fire("Enable", "", "0")
    end

    for _, v in pairs(ents.FindByName("Blocker")) do
        v:Fire("Disable", "", "0")
    end
end

-- Disable the "pusher" at the end of a round
function GM:DisableRoundPush()
    for _, v in pairs(ents.FindByName("Pusher")) do
        v:Fire("Disable", "", "0")
    end

    for _, v in pairs(ents.FindByName("Blocker")) do
        v:Fire("Enable", "", "0")
    end
end

-- Call when a player has crossed the finish line
function GM:CrossFinish(ent)
    -- Todo: properly track finishes and all that fun jazz
    -- For now we just treat everyone like winners
    local finishpos = 1
    local destination = GAMEMODE:GetDestinationPosition(finishpos)
    local vehicle = ent:GetVehicle()
    GAMEMODE:RelocateSled(vehicle, destination)
end

-- Relocate a sled to a new position
-- This should specify the vehicle/chair to move
function GM:RelocateSled(vehicle, pos)
    local basepos = vehicle:GetPos()
    local constrained = constraint.GetAllConstrainedEntities(vehicle)
    for _, component in (constrained) do
        component:SetPos(pos + (component:GetPos() - basepos)) -- calculate offset
        component:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER) -- do we need this?
    end
end