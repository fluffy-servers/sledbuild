-- Start a new round
function GM:StartRound()
    -- Network to clients
    net.Start("SBStartRound")
    net.Broadcast()

    PrintMessage(3, "The race has begun!")

    -- Handle round pushing
    self:EnableRoundPush()
    timer.Simple(10, self.DisableRoundPush)
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