-- Load client files
include("shared.lua")
include("cl_spawnmenu.lua")
include("sh_convars.lua")

-- Play sound on round start
net.Receive("SBStartRound", function()
    local number = net.ReadInt(16)
    chat.AddText(color_white, "Race ", Color(0, 151, 230), "#", tostring(number), color_white, " has begun!")
    surface.PlaySound("ambient/alarms/warningbell1.wav")
end)