ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:StartTouch(ent)
    if ent:IsPlayer() then
        if not ent:InVehicle() then
            ent:Kill()
            return
        end

        local vehicle = ent:GetVehicle()
        if not IsValid(vehicle) then return end

        GAMEMODE:CrossFinish(vehicle)
    elseif ent:IsVehicle() and !IsValid(ent:GetDriver()) then
        -- Recover lost sleds
        local destination = GAMEMODE:GetDestinationPosition(-1)
        GAMEMODE:RelocateSled(ent, destination)
    end
end