ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:StartTouch(ent)
    if ent:IsPlayer() then
        ent:SetNWBool("Racing", true)
    else
        local phys = ent:GetPhysicsObject()
        if phys and phys:IsValid() then
            phys:SetMaterial("gmod_ice")
        end
    end
end

function ENT:EndTouch(ent)
    if ent:IsPlayer() then
        ent:SetNWBool("Racing", false)
    else
        local phys = ent:GetPhysicsObject()
        if phys and phys:IsValid() then
            phys:SetMaterial("dirt")
        end
    end
end