-- All ConVars go in here

-- Shared ConVars
    CreateConVar("slb_construction_time", 180, FCVAR_ARCHIVE + FCVAR_REPLICATED, "The construction time given before a race starts")
    CreateConVar("slb_race_time", 60, FCVAR_ARCHIVE + FCVAR_REPLICATED, "The duration of a race")

if SERVER then
    -- Server side ConVars
    CreateConVar("slb_max_prop_radius", 128, FCVAR_ARCHIVE, "Max prop radius, any props larger than the set radius will be removed")

elseif CLIENT then
    -- Client side ConVars

end