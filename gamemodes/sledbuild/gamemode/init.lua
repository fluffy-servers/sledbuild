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