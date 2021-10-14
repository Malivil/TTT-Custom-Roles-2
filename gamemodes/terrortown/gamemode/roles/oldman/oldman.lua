AddCSLuaFile()

util.AddNetworkString("TTT_UpdateOldManWins")

resource.AddSingleFile("sound/oldmanramble.wav")

-------------
-- CONVARS --
-------------

CreateConVar("ttt_oldman_drain_health_to", "0")
CreateConVar("ttt_oldman_adrenaline_rush", "5")
CreateConVar("ttt_oldman_adrenaline_shotgun", "1")

hook.Add("TTTSyncGlobals", "OldMan_TTTSyncGlobals", function()
    SetGlobalInt("ttt_oldman_drain_health_to", GetConVar("ttt_oldman_drain_health_to"):GetInt())
    SetGlobalInt("ttt_oldman_adrenaline_rush", GetConVar("ttt_oldman_adrenaline_rush"):GetInt())
    SetGlobalBool("ttt_oldman_adrenaline_shotgun", GetConVar("ttt_oldman_adrenaline_shotgun"):GetBool())
end)

----------------
-- WIN CHECKS --
----------------

local function HandleOldManWinChecks(win_type)
    if win_type == WIN_NONE then return end
    if not player.IsRoleLiving(ROLE_OLDMAN) then return end

    net.Start("TTT_UpdateOldManWins")
    net.WriteBool(true)
    net.Broadcast()
end
hook.Add("TTTWinCheckComplete", "OldMan_TTTWinCheckComplete", HandleOldManWinChecks)

-------------------
-- ROLE FEATURES --
-------------------

-- Manage health drain
hook.Add("TTTEndRound", "OldMan_RoleFeatures_TTTEndRound", function()
    if timer.Exists("oldmanhealthdrain") then timer.Remove("oldmanhealthdrain") end
end)

ROLE_ON_ROLE_ASSIGNED[ROLE_OLDMAN] = function(ply)
    local oldman_drain_health = GetConVar("ttt_oldman_drain_health_to"):GetInt()
    if oldman_drain_health > 0 then
        timer.Create("oldmanhealthdrain", 3, 0, function()
            for _, p in pairs(player.GetAll()) do
                if p:IsActiveOldMan() then
                    local hp = p:Health()
                    if hp > oldman_drain_health then
                        p:SetHealth(hp - 1)
                    end

                    local max = p:GetMaxHealth()
                    if max > oldman_drain_health then
                        p:SetMaxHealth(max - 1)
                    end
                end
            end
        end)
    end
end

hook.Add("EntityTakeDamage", "OldMan_EntityTakeDamage", function(ent, dmginfo)
    if not IsValid(ent) then return end

    local att = dmginfo:GetAttacker()
    if GetRoundState() >= ROUND_ACTIVE and ent:IsPlayer() then
        local adrenalineTime = GetConVar("ttt_oldman_adrenaline_rush"):GetInt()
        if ent:IsOldMan() and adrenalineTime > 0 then
            local damage = dmginfo:GetDamage()
            local health = ent:Health()

            if ent:IsRoleActive() then -- If they are mid adrenaline rush then they take no damage
                dmginfo:ScaleDamage(0)
                dmginfo:SetDamage(0)
            elseif IsPlayer(att) and damage >= health then -- If they are attacked by a player that would have killed them they enter an adrenaline rush
                dmginfo:SetDamage(health - 1)
                ent:SetNWBool("AdrenalineRush", true)
                ent:EmitSound("oldmanramble.wav")
                ent:PrintMessage(HUD_PRINTTALK, "You are having an adrenaline rush! You will die in " .. tostring(adrenalineTime) .. " seconds.")

                if GetConVar("ttt_oldman_adrenaline_shotgun"):GetBool() then
                    for _, wep in ipairs(ent:GetWeapons()) do
                        if wep.Kind == WEAPON_HEAVY then
                            ent:StripWeapon(wep:GetClass())
                        end
                    end
                    ent:Give("weapon_old_dbshotgun")
                    ent:SelectWeapon("weapon_old_dbshotgun")
                end

                timer.Create(ent:Nick() .. "AdrenalineRush", adrenalineTime, 1, function()
                    ent:SetNWBool("AdrenalineRush", false)
                    if ent:IsActiveOldMan() then ent:Kill() end -- Only kill them if they are still the old man
                end)
            end
        end
    end
end)