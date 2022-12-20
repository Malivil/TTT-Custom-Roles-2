AddCSLuaFile()

local hook = hook
local IsValid = IsValid
local math = math
local net = net
local pairs = pairs
local player = player
local table = table
local timer = timer

local GetAllPlayers = player.GetAll

-------------
-- CONVARS --
-------------

CreateConVar("ttt_cupid_notify_mode", "0", FCVAR_NONE, "The logic to use when notifying players that a cupid was killed", 0, 4)
CreateConVar("ttt_cupid_notify_sound", "0", FCVAR_NONE, "Whether to play a cheering sound when a cupid is killed", 0, 1)
CreateConVar("ttt_cupid_notify_confetti", "0", FCVAR_NONE, "Whether to throw confetti when a cupid is a killed", 0, 1)
CreateConVar("ttt_cupid_lovers_notify_mode", "1", FCVAR_NONE, "Who is notified with cupid makes two players fall in love", 0, 3)
local cupids_are_independent = CreateConVar("ttt_cupids_are_independent", "0", FCVAR_NONE, "Whether cupids should be treated as members of the independent team", 0, 1)
local cupid_can_damage_lovers = CreateConVar("ttt_cupid_can_damage_lovers", "0", FCVAR_NONE, "Whether cupid should be able to damage the lovers", 0, 1)
local cupid_lovers_can_damage_lovers = CreateConVar("ttt_cupid_lovers_can_damage_lovers", "1", FCVAR_NONE, "Whether the lovers should be able to damage each other", 0, 1)
local cupid_lovers_can_damage_cupid = CreateConVar("ttt_cupid_lovers_can_damage_cupid", "0", FCVAR_NONE, "Whether the lovers should be able to damage cupid", 0, 1)

hook.Add("TTTSyncGlobals", "Cupid_TTTSyncGlobals", function()
    SetGlobalBool("ttt_cupids_are_independent", cupids_are_independent:GetBool())
end)

----------------
-- DEATH LINK --
----------------

hook.Add("TTTBeginRound", "Cupid_TTTBeginRound", function()
    timer.Create("TTTCupidTimer", 0.1, 0, function()
        for _, v in pairs(GetAllPlayers()) do
            local lover = v:GetNWString("TTTCupidLover", "")
            if lover ~= "" then
                if v:IsActive() and not player.GetBySteamID64(lover):IsActive() then
                    v:Kill()
                    v:PrintMessage(HUD_PRINTCENTER, "Your lover has died!")
                    v:PrintMessage(HUD_PRINTTALK, "Your lover has died!")
                end
            end
        end
    end)
end)


-------------
-- CLEANUP --
-------------

hook.Add("TTTPrepareRound", "Cupid_TTTPrepareRound", function()
    for _, v in pairs(GetAllPlayers()) do
        v:SetNWString("TTTCupidShooter", "")
        v:SetNWString("TTTCupidLover", "")
        v:SetNWString("TTTCupidTarget1", "")
        v:SetNWString("TTTCupidTarget2", "")
    end
end)

------------
-- DAMAGE --
------------

hook.Add("ScalePlayerDamage", "Cupid_ScalePlayerDamage", function(ply, hitgroup, dmginfo)
    local att = dmginfo:GetAttacker()
    local target = ply:SteamID64()
    if IsPlayer(att) and GetRoundState() >= ROUND_ACTIVE then
        if (att:IsCupid() and (att:GetNWString("TTTCupidTarget1", "") == target or att:GetNWString("TTTCupidTarget2", "") == target) and not cupid_can_damage_lovers:GetBool())
                or (att:GetNWString("TTTCupidLover", "") == target and not cupid_lovers_can_damage_lovers:GetBool())
                or (att:GetNWString("TTTCupidShooter", "") == target and not cupid_lovers_can_damage_cupid:GetBool()) then
            dmginfo:ScaleDamage(0)
        end
    end
end)

----------------
-- WIN CHECKS --
----------------

hook.Add("PlayerDeath", "Cupid_PlayerDeath", function(victim, infl, attacker)
    local cupidWin = true
    for _, v in pairs(GetAllPlayers()) do
        if v:IsActive() then
            local lover = v:GetNWString("TTTCupidLover", "")
            if lover ~= "" then
                if not player.GetBySteamID64(lover):IsActive() then
                    cupidWin = false
                    break
                end
            elseif not v:IsCupid() then
                cupidWin = false
                break
            end
        end
    end

    if cupidWin then
        StopWinChecks()
        EndRound(WIN_CUPID)
    end
end)

hook.Add("TTTPrintResultMessage", "Killer_TTTPrintResultMessage", function(type)
    if type == WIN_JESTER then
        LANG.Msg("win_jester", { role = ROLE_STRINGS_PLURAL[ROLE_JESTER] })
        ServerLog("Result: " .. ROLE_STRINGS[ROLE_JESTER] .. " wins.\n")
    end
end)

-- TODO: Role icons
-- TODO: Add convars to CONVARS.md
-- TODO: Lover outline through walls