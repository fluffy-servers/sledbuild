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

hook.Add("PopulatePropMenu", "SledbuildTestCategory", function()
    local base_vehicles = list.Get("Vehicles")
    local contents = {
        {type = "header", text = "Props"},
        {type = "model", model = "models/props_c17/oildrum001.mdl"},
        {type = "header", text = "Seats"},
        {type = "vehicle", spawnname = "Chair_Office1", nicename = "Office Chair", material="entities/Chair_Office1.png"}
    }
    spawnmenu.AddPropCategory("Sledbuild1", "Sledbuild Recommended", contents, "icon16/weather_snow.png")
end)