-- Load client files
include("shared.lua")
include("cl_spawnmenu.lua")
include("sh_convars.lua")

-- Play sound on round start
net.Receive("SBStartRound", function()
    surface.PlaySound("ambient/alarms/warningbell1.wav")
end)