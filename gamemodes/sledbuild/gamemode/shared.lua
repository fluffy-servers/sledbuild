DeriveGamemode("sandbox")

GM.Name = "Sledbuild Remastered"
GM.Author = "Fluffy Servers"

-- Disable dupes
-- TODO: convar to enable
function GM:CanArmDupe(ply)
    return false
end