AddCSLuaFile()

local function InitializeEquipment()
    if DefaultEquipment then
        DefaultEquipment[ROLE_HYPNOTIST] = {
            "weapon_hyp_brainwash",
            EQUIP_ARMOR,
            EQUIP_RADAR,
            EQUIP_DISGUISE
        }
    end
end
InitializeEquipment()

hook.Add("Initialize", "Hypnotist_Shared_Initialize", function()
    InitializeEquipment()
end)
hook.Add("TTTPrepareRound", "Hypnotist_Shared_TTTPrepareRound", function()
    InitializeEquipment()
end)

-----------------
-- ROLE WEAPON --
-----------------

hook.Add("TTTUpdateRoleState", "Hypnotist_TTTUpdateRoleState", function()
    local hypnotist_defib = weapons.GetStored("weapon_hyp_brainwash")
    if GetGlobalBool("ttt_hypnotist_device_loadout", false) then
        hypnotist_defib.InLoadoutFor = table.Copy(hypnotist_defib.InLoadoutForDefault)
    else
        table.Empty(hypnotist_defib.InLoadoutFor)
    end
    if GetGlobalBool("ttt_hypnotist_device_shop", false) then
        hypnotist_defib.CanBuy = {ROLE_HYPNOTIST}
        hypnotist_defib.LimitedStock = not GetGlobalBool("ttt_hypnotist_device_shop_rebuyable", false)
    else
        hypnotist_defib.CanBuy = nil
        hypnotist_defib.LimitedStock = true
    end
end)