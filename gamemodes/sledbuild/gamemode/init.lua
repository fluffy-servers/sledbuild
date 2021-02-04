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

-- Start the first round at the appropiate time
hook.Add("Initialize", "StartFirstSledbuildRound", function()
    local time = GetConVar("slb_construction_time"):GetInt() or 120
    timer.Create("SledbuildRoundStart", time, 1, GAMEMODE.StartRound)
end)

-- Get the destination position for a given race position
-- If in the top 3, use the winning destinations
-- Otherwise, use any of the 'loser' destinations
function GM:GetDestinationPosition(index)
    if index >= 1 and index <= 3 then
        return GAMEMODE.WinDestinations[index]
    else
        return table.Random(GAMEMODE.LoseDestinations)
    end
end

-- Register the positions of the destination entities as soon as the round starts
-- todo: make it a tad more flexible
hook.Add("InitPostEntity", "PrepareDestinationLocations", function()
    GAMEMODE.WinDestinations = {}
    GAMEMODE.WinDestinations[1] = ents.FindByName("Destination_1st")[1]:GetPos()
    GAMEMODE.WinDestinations[2] = ents.FindByName("Destination_2nd")[1]:GetPos()
    GAMEMODE.WinDestinations[3] = ents.FindByName("Destination_3rd")[1]:GetPos()

    GAMEMODE.LoseDestinations = {}
    for _, ent in pairs(ents.FindByName("Destination_Lose*")) do
        table.insert(GAMEMDOE.LoseDestinations, ent:GetPos())
    end
end)