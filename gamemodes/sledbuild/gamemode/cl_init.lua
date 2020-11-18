-- Load client files
include("shared.lua")

-- Play sound on round start
net.Receive("SBStartRound", function()
    surface.PlaySound("ambient/alarms/warningbell1.wav")
end)