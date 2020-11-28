DeriveGamemode("sandbox")

GM.Name = "Sledbuild Remastered"
GM.Author = "Fluffy Servers"

-- Disable dupes
-- TODO: convar to enable
function GM:CanArmDupe(ply)
    return false
end

GM.AllowedTools = {
    ["weld"] = true,
    ["remover"] = true,
    ["camera"] = true,
    ["colour"] = true,
    ["material"] = true,
    ["trails"] = true,
    ["axis"] = true,
    ["rope"] = true
}