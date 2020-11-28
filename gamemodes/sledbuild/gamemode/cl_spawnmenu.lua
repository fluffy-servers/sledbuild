local allowed_tabs = {
    ["#spawnmenu.content_tab"] = true,
    ["#spawnmenu.category.vehicles"] = true
}

hook.Add("SpawnMenuOpen", "BlockMenuTabs", function()
    for _, v in pairs(g_SpawnMenu.CreateMenu.Items) do
        if not allowed_tabs[v.Name] then
            -- TODO: Let dupes tab stay open with a convar
            g_SpawnMenu.CreateMenu:CloseTab(v.Tab, true)
        end
    end
end)

function GM:GetVehicleInfo(name)
    local vehicle = list.Get("Vehicles")[name]
    vehicle.ClassName = name
    vehicle.PrintName = vehicle.name
    vehicle.ScriptedEntityType = "vehicle"
    return vehicle
end

hook.Add("PopulatePropMenu", "SledbuildSpawnMenu", function()
    local base_vehicles = list.Get("Vehicles")
    local contents = {
        {type = "header", text = "Props"},
        {type = "model", model = "models/props_c17/oildrum001.mdl"},
        {type = "header", text = "Seats"},
        {type = "vehicle", spawnname = "Chair_Office1", nicename = "Office Chair", material="entities/Chair_Office1.png"},
        {type = "vehicle", spawnname = "Chair_Office2", nicename = "Breen's Recliner", material="entities/Chair_Office2.png"},
        {type = "vehicle", spawnname = "Seat_Airboat", nicename = "Airboat Seat", material="entities/Seat_Airboat.png"},
        {type = "vehicle", spawnname = "Seat_Jeep", nicename = "Jeep Seat", material="entities/Seat_Jeep.png"},
        {type = "vehicle", spawnname = "Chair_Wood", nicename = "Wooden Chair", material="entities/Chair_Wood.png"},
        {type = "vehicle", spawnname = "Chair_Plastic", nicename = "Plastic Chair", material="entities/Chair_Plastic.png"},
        {type = "vehicle", spawnname = "Pod", nicename = "Combine Pod", material="entities/Pod.png"}
    }
    spawnmenu.AddPropCategory("Sledbuild1", "Sledbuild Recommended", contents, "icon16/weather_snow.png")
end)

hook.Add("AddToolMenuTabs", "SledbuildToolTab", function()
    spawnmenu.AddToolTab("SledbuildTab", "Sledbuild", "icon16/weather_snow.png")
end)

hook.Add("AddToolMenuCategories", "SledbuildToolCategory", function()
    spawnmenu.AddToolCategory("SledbuildTab", "Sledbuild", "Sledbuild")

    local tools = allowed_tools

    for name, _ in pairs(GAMEMODE.AllowedTools) do
    spawnmenu.AddToolMenuOption("SledbuildTab", "Sledbuild", name, "#tool." .. name .. ".name", "gmod_tool " .. name, name)
    end
end)