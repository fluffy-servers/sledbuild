-- Load server files
include("shared.lua")
include("sv_construction.lua")
include("sv_round.lua")

-- Register net messages
util.AddNetworkString("SBStartRound")

-- Send required files to clients
AddCSLuaFile("shared.lua")