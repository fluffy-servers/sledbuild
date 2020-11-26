-- Load server files
include("shared.lua")
include("sv_construction.lua")
include("sv_round.lua")
include("sh_convars.lua")

-- Register net messages
util.AddNetworkString("SBStartRound")

-- Send required files to clients
AddCSLuaFile("cl_spawnmenu.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_convars.lua")

function GM:PlayerLoadout(ply)
    ply:StripWeapons()
    ply:StripAmmo()

    ply:Give("weapon_physgun")
    ply:Give("gmod_tool")
    ply:Give("gmod_camera")
end

hook.Add("Initialize", "StartFirstSledbuildRound", function()
    local time = GetConVar("slb_construction_time"):GetInt() or 120
    timer.Create("SledbuildRoundStart", time, 1, GAMEMODE.StartRound)
end)