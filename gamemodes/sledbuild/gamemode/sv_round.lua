function GM:GetNextRaceNumber()
    GetGlobalInt("NextRace", 1)
end

function GM:UpdateNextRaceNumber()
    SetGlobalInt("NextRace", self:GetNextRaceNumber() + 1)
end

-- Start a new round
function GM:StartRound()
    timer.Stop("SledbuildRoundStart")

    -- Network to clients
    net.Start("SBStartRound")
        net.WriteInt(self:GetNextRaceNumber())
    net.Broadcast()

    -- Handle round pushing
    self:EnableRoundPush()
    timer.Simple(10, self.DisableRoundPush)

    -- Setup timer to kill the round
    local racetime = GetConVar("slb_race_time"):GetInt() or 60
    timer.Create("SledbuildRoundEnd", racetime, 1, self.EndRound)
end

function GM:EndRound()
    timer.Stop("SledbuildRoundEnd")

    -- Increment the race number
    self:UpdateNextRaceNumber()
    
    -- Prepare for the next race
    local time_til_next_race = GetConVar("slb_construction_time"):GetInt() or 0
    if time_til_next_race <= 0 then
        self:StartRound()
    else
        timer.Create("SledbuildRoundStart", time_til_next_race, 1, self.StartRound)
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