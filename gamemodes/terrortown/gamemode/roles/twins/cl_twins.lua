------------------
-- TRANSLATIONS --
------------------

hook.Add("Initialize", "Twins_Translations_Initialize", function()
    -- HUD
    LANG.AddToLanguage("english", "twins_hud", "Invulnerability ends in: {time}")

    -- Popup
    LANG.AddToLanguage("english", "info_popup_goodtwin", [[You are {role}!
You have a twin on the traitor team that knows who you are.
However, you and your twin are unable to damage each other.
If you are the last twin left alive you get temporary invulnerability.
Try to convince everyone that you are the good twin!]])

    LANG.AddToLanguage("english", "info_popup_eviltwin", [[You are {role}! {comrades}

You have a twin on the innocent team that knows who you are.
However, you and your twin are unable to damage each other.
If you are the last twin left alive you get temporary invulnerability.
Try to trick everyone into thinking you are the good twin!

Press {menukey} to receive your special equipment!]])
end)

---------------
-- TARGET ID --
---------------

hook.Add("TTTTargetIDPlayerRoleIcon", "Twins_TTTTargetIDPlayerRoleIcon", function(ply, cli, role, noz, colorRole, hideBeggar, showJester, hideBodysnatcher)
    if not cli:IsActiveTwin() then return end
    if ply == cli then return end

    if ply:IsActiveGoodTwin() then
        return ROLE_GOODTWIN, false
    elseif ply:IsActiveEvilTwin() then
        return ROLE_EVILTWIN, cli:IsActiveEvilTwin()
    end
end)

hook.Add("TTTTargetIDPlayerRing", "Twins_TTTTargetIDPlayerRing", function(ent, cli, ringVisible)
    if not IsPlayer(ent) then return end
    if not cli:IsActiveTwin() then return end
    if ent == cli then return end

    if ent:IsActiveTwin() then
        return true, ROLE_COLORS_RADAR[ent:GetRole()]
    end
end)

hook.Add("TTTTargetIDPlayerText", "Twins_TTTTargetIDPlayerText", function(ent, cli, text, col)
    if not IsPlayer(ent) then return end
    if not cli:IsActiveTwin() then return end
    if ent == cli then return end

    if ent:IsActiveTwin() then
        local role = ent:GetRole()
        return string.upper(ROLE_STRINGS[role]), ROLE_COLORS_RADAR[role]
    end
end)

ROLE_IS_TARGETID_OVERRIDDEN[ROLE_GOODTWIN] = function(ply, target, showJester)
    if not IsPlayer(target) then return end

    if ply:IsActiveGoodTwin() and target:IsActiveTwin() then
        return true, true, true
    end
end

ROLE_IS_TARGETID_OVERRIDDEN[ROLE_EVILTWIN] = function(ply, target, showJester)
    if not IsPlayer(target) then return end

    if ply:IsActiveEvilTwin() and target:IsActiveTwin() then
        return true, true, true
    end
end

----------------
-- SCOREBOARD --
----------------

hook.Add("TTTScoreboardPlayerRole", "Twins_TTTScoreboardPlayerRole", function(ply, cli, color, roleFileName)
    if not cli:IsActiveTwin() then return end
    if ply == cli then return end

    if ply:IsTwin() then
        local role = ply:GetRole()
        return ROLE_COLORS_SCOREBOARD[role], ROLE_STRINGS_SHORT[role]
    end
end)

ROLE_IS_SCOREBOARD_INFO_OVERRIDDEN[ROLE_GOODTWIN] = function(ply, target)
    return false, ply:IsActiveGoodTwin() and target:IsActiveTwin()
end

ROLE_IS_SCOREBOARD_INFO_OVERRIDDEN[ROLE_EVILTWIN] = function(ply, target)
    return false, ply:IsActiveEvilTwin() and target:IsActiveTwin()
end

---------
-- HUD --
---------

local hide_role = GetConVar("ttt_hide_role")

hook.Add("TTTHUDInfoPaint", "Twins_TTTHUDInfoPaint", function(client, label_left, label_top, active_labels)
    if hide_role:GetBool() then return end

    local invulnerabilityEnd = client:GetNWFloat("TTTTwinsInvulnerabilityEnd", 0)

    if client:IsActiveTwin() and client:IsInvulnerable() and invulnerabilityEnd > 0 then
        surface.SetFont("TabLarge")
        surface.SetTextColor(255, 255, 255, 230)

        local remaining = math.max(0, invulnerabilityEnd - CurTime())
        local text = LANG.GetParamTranslation("twins_hud", { time = util.SimpleTime(remaining, "%02i:%02i") })
        local _, h = surface.GetTextSize(text)

        -- Move this up based on how many other labels here are
        label_top = label_top + (20 * #active_labels)

        surface.SetTextPos(label_left, ScrH() - label_top - h)
        surface.DrawText(text)

        -- Track that the label was added so others can position accurately
        table.insert(active_labels, "twins")
    end
end)

--------------
-- TUTORIAL --
--------------

hook.Add("TTTTutorialRoleText", "Twins_TTTTutorialRoleText", function(role, titleLabel)
    if role == ROLE_GOODTWIN then
        local roleColor = ROLE_COLORS[ROLE_INNOCENT]
        local traitorColor = ROLE_COLORS[ROLE_TRAITOR]

        local html = "The " .. ROLE_STRINGS[ROLE_GOODTWIN] .. " is a member of the <span style='color: rgb(" .. roleColor.r .. ", " .. roleColor.g .. ", " .. roleColor.b .. ")'>innocent team</span> who has an evil counterpart on the <span style='color: rgb(" .. traitorColor.r .. ", " .. traitorColor.g .. ", " .. traitorColor.b .. ")'>traitor team</span>."

        html = html .. "<span style='display: block; margin-top: 10px;'>The twins rgb(" .. roleColor.r .. ", " .. roleColor.g .. ", " .. roleColor.b .. ")'>cannot damage each other</span> unless they are the last non-jester players alive."

        local invulnerability_timer = GetConVar("ttt_twins_invulnerability_timer"):GetInt()
        if invulnerability_timer > 0 then
            html = html .. "<span style='display: block; margin-top: 10px;'>If one twin dies, the other is given " .. invulnerability_timer .. " second(s) of invulnerability."
        end

        return html
    elseif role == ROLE_EVILTWIN then
        local roleColor = ROLE_COLORS[ROLE_TRAITOR]
        local innocentColor = ROLE_COLORS[ROLE_INNOCENT]

        local html = "The " .. ROLE_STRINGS[ROLE_EVILTWIN] .. " is a member of the <span style='color: rgb(" .. roleColor.r .. ", " .. roleColor.g .. ", " .. roleColor.b .. ")'>traitor team</span> who has a good counterpart on the <span style='color: rgb(" .. innocentColor.r .. ", " .. innocentColor.g .. ", " .. innocentColor.b .. ")'>innocent team</span>."

        html = html .. "<span style='display: block; margin-top: 10px;'>The twins rgb(" .. roleColor.r .. ", " .. roleColor.g .. ", " .. roleColor.b .. ")'>cannot damage each other</span> unless they are the last non-jester players alive."

        local invulnerability_timer = GetConVar("ttt_twins_invulnerability_timer"):GetInt()
        if invulnerability_timer > 0 then
            html = html .. "<span style='display: block; margin-top: 10px;'>If one twin dies, the other is given " .. invulnerability_timer .. " second(s) of invulnerability."
        end

        return html
    end
end)