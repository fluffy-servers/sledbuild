ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:StartTouch(ent)
    if ent:IsPlayer() then
        ent.OnTrack = false
    end
end

function ENT:EndTouch(ent)
    if ent:IsPlayer() then
        ent.OnTrack = false
    end
end