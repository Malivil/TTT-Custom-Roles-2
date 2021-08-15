# Application Programming Interface (API)
## Table of Contents
1. [Overview](#Overview)
1. [Global Variables](#Global-Variables)
1. [Methods](#Methods)
   1. [Global](#Global)
   1. [Player](#Player)
1. [Hooks](#Hooks)
1. [SWEPs](#SWEPs)
   1. [SWEP Properties](#SWEP-Properties)
1. [Commands](#Commands)
   1. [Client Commands](#Client-Commands)
   1. [Server Commands](#Server-Commands)
1. [Net Messages](#Net-Messages)

## Overview
This document aims to explain the things that we have added to Custom Roles for TTT that are usable by other developers for integration.

## Global Variables
**CAN_LOOT_CREDITS_ROLES** - Lookup table for whether a role can loot credits off of a corpse.\
*Realm:* Client and Server\
*Added in:* 1.0.5

**COLOR_INNOCENT** - Table of the default colors to use for the innocent role for each color type.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**COLOR_SPECIAL_INNOCENT** - Table of the default colors to use for the special innocent roles for each color type.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**COLOR_TRAITOR** - Table of the default colors to use for the traitor role for each color type.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**COLOR_SPECIAL_TRAITOR** - Table of the default colors to use for the special traitor roles for each color type.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**COLOR_DETECTIVE** - Table of the default colors to use for the detective role for each color type.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**COLOR_JESTER** - Table of the default colors to use for the jester roles for each color type.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**COLOR_INDEPENDENT** - Table of the default colors to use for the independent roles for each color type.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**COLOR_MONSTER** - Table of the default colors to use for the monster team for each color type.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**CR_VERSION** - The current version number for Custom Roles for TTT.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**ROLE_NONE** - Updated to be -1 so players who have not been given a role can be identified.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**ROLE_MAX** - The maximum role number.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**ROLE_EXTERNAL_START** - The role number where the externally-loaded roles start.\
*Realm:* Client and Server\
*Added in:* 1.0.10

**ROLE_STRINGS** - Table of title-case names for each role.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**ROLE_STRINGS_EXT** - Table of extended (e.g. prefixed by an article) names for each role.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**ROLE_STRINGS_PLURAL** - Table of pluralized names for each role.\
*Realm:* Client and Server\
*Added in:* 1.0.7

**ROLE_STRINGS_RAW** - Table of raw names for each role (used in convars).\
*Realm:* Client and Server\
*Added in:* 1.0.7

**ROLE_STRINGS_SHORT** - Table of short names for each role (used in icon names).\
*Realm:* Client and Server\
*Added in:* 1.0.0

**SHOP_ROLES** - Lookup table for whether a role has a shop.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**DEFAULT_ROLES** - Lookup table for whether a role is a default TTT role.\
*Realm:* Client and Server\
*Added in:* 1.0.3

**INDEPENDENT_ROLES** - Lookup table for whether a role is on the independent team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**INNOCENT_ROLES** - Lookup table for whether a role is on the innocent team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**JESTER_ROLES** - Lookup table for whether a role is on the jester team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**MONSTER_ROLES** - Lookup table for whether a role is on the monster team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**TRAITOR_BUTTON_ROLES** - Lookup table for whether a role can use traitor buttons.\
*Realm:* Client and Server\
*Added in:* 1.0.5

**TRAITOR_ROLES** - Lookup table for whether a role is on the traitor team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

## Methods

### *Global*

**CRVersion(version)** - Whether the current version is equal to or newer than the version number given.\
*Realm:* Client and Server\
*Added in:* 1.0.0\
*Parameters:*
- *version* - The version number to compare against the currently installed version. Must be in the "#.#.#" format

**GetEquipmentItemById(id)** - Gets an equipment item's definition by their ID.\
*Realm:* Client and Server\
*Added in:* 1.0.0\
*Parameters:*\
*Parameters:*
- *id* - The ID of the equipment item being looked up (e.g. EQUIP_RADAR)

**GetEquipmentItemByName(name)** - Gets an equipment item's definition by their name.\
*Realm:* Client and Server\
*Added in:* 1.0.0\
*Parameters:*
- *name* - The name of the equipment item being looked up

**Get{RoleName}Filter(alive_only)** - Dynamically created functions for each role that returns a function that filters net messages to players that are role. For example: `GetTraitorFilter()` and `GetPhantomFilter()` return a filter function that can be used to send a message to players who are a traitor or a phantom, respectively.\
*Realm:* Server\
*Added in:* Whenever each role is added\
*Parameters:*
- *alive_only* - Whether this filter should only include live players (Defaults to `false`).

**GetTraitorTeamFilter(alive_only)** - Returns a function that filters net messages to players that are on the traitor team.\
*Realm:* Server\
*Added in:* 1.0.0\
*Parameters:*
- *alive_only* - Whether this filter should only include live players (Defaults to `false`).

**GetInnocentTeamFilter(alive_only)** - Returns a function that filters net messages to players that are on the innocent team.\
*Realm:* Server\
*Added in:* 1.0.0\
*Parameters:*
- *alive_only* - Whether this filter should only include live players (Defaults to `false`).

**GetJesterTeamFilter(alive_only)** - Returns a function that filters net messages to players that are on the jester team.\
*Realm:* Server\
*Added in:* 1.0.0\
*Parameters:*
- *alive_only* - Whether this filter should only include live players (Defaults to `false`).

**GetIndependentTeamFilter(alive_only)** - Returns a function that filters net messages to players that are on the independent team.\
*Realm:* Server\
*Added in:* 1.0.0\
*Parameters:*
- *alive_only* - Whether this filter should only include live players (Defaults to `false`).

**GetMonsterTeamFilter(alive_only)** - Returns a function that filters net messages to players that are on the monster team.\
*Realm:* Server\
*Added in:* 1.0.0\
*Parameters:*
- *alive_only* - Whether this filter should only include live players (Defaults to `false`).

**GetTeamRoles(team_table)** - Gets a table of role numbers that belong to the team whose lookup table is given.\
*Realm:* Client and Server\
*Added in:* 1.0.2\
*Parameters:*
- *team_table* - Team lookup table

**UpdateRoleColours()/UpdateRoleColors()** - Updates the role color tables based on the color convars and color type convar.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**UpdateRoleStrings()** - Updates the role string tables based on the role name convars.\
*Realm:* Client and Server\
*Added in:* 1.0.7

**RegisterRole**\

**GetSprintMultiplier(ply, sprinting)** - Gets the given player's current sprint multiplier.\
*Realm:* Client and Server\
*Added in:* 1.0.0\
*Parameters:*
- *ply* - The target player
- *sprinting* - Whether the player is currently sprinting

**UpdateRoleWeaponState()** - Enables and disables weapons based on which roles are enabled.\
*Realm:* Client and Server\
*Added in:* 1.0.5

**UpdateRoleState()** - Updates the team membership, colors, and weapon state based on which roles are enabled and belong to which teams.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**AssignAssassinTarget(ply, start, delay)** - Assigns the target player their next assassination target (if they are the assassin role).\
*Realm:* Client and Server\
*Added in:* 1.0.0\
*Parameters:*
- *ply* - The target player
- *start* - Whether this is running at the start of the round (Defaults to `false`).
- *delay* - Whether the assassin's target assignment is delayed (Defaults to false)

**SetRoleHealth(ply)** - Sets the target player's health and max health based on their role convars.\
*Realm:* Client and Server\
*Added in:* 1.0.3\
*Parameters:*
- *ply* - The target player

**SetRoleMaxHealth(ply)** - Sets the target player's max health based on their role convars.\
*Realm:* Client and Server\
*Added in:* 1.0.15\
*Parameters:*
- *ply* - The target player

**SetRoleStartingHealth(ply)** - Sets the target player's health based on their role convars.\
*Realm:* Client and Server\
*Added in:* 1.0.15\
*Parameters:*
- *ply* - The target player

### *Player*

**plymeta:Is{RoleName}()/plymeta:Get{RoleName}()** - Dynamically created functions for each role that returns whether the player is that role. For example: `plymeta:IsTraitor()` and `plymeta:IsPhantom()` return whether the player is a traitor or a phantom, respectively.\
*Realm:* Client and Server\
*Added in:* Whenever each role is added

**plymeta:IsActive{RoleName}()** - Dynamically created functions for each role that returns whether `plymeta:Is{RoleName}` returns `true` and the player is active. For example: `plymeta:IsActiveTraitor()` and `plymeta:IsActivePhantom()` return whether the player is active and a traitor or a phantom, respectively.\
*Realm:* Client and Server\
*Added in:* Whenever each role is added

**plymeta:IsActiveCustom()** - Whether `plymeta:IsCustom` returns `true` and the player is active.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsActiveDetectiveLike()** - Whether `plymeta:IsActiveDetectiveLike` returns `true` and the player is active.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsActiveIndependentTeam()** - Whether `plymeta:IsIndependentTeam` returns `true` and the player is active.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsActiveInnocentTeam()** - Whether `plymeta:IsInnocentTeam` returns `true` and the player is active.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsActiveJesterTeam()** - Whether `plymeta:IsJesterTeam` returns `true` and the player is active.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsActiveMonsterTeam()** - Whether `plymeta:IsMonsterTeam` returns `true` and the player is active.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsActiveTraitorTeam()** - Whether `plymeta:IsTraitorTeam` returns `true` and the player is active.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsActiveShopRole()** - Whether `plymeta:IsActiveShopRole` returns `true` and the player is active.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:CanLootCredits(active_only)** - Whether the player can loot credits from a corpse that has them.\
*Realm:* Client and Server\
*Added in:* 1.0.5\
*Parameters:*
- *active_only* - Whether the player must also be active (Defaults to `false`)

**plymeta:CanUseShop()** - Whether the player can currently open the shop menu.\
*Realm:* Client and Server\
*Added in:* 1.0.2

**plymeta:CanUseTraitorButton(active_only)** - Whether the player can see and use traitor buttons.\
*Realm:* Client and Server\
*Added in:* 1.0.5\
*Parameters:*
- *active_only* - Whether the player must also be active (Defaults to `false`)

**plymeta:GetHeight()** - Gets the *estimated* height of the player based on their player model.\
*Realm:* Client\
*Added in:* 1.0.2

**plymeta:GetVampirePreviousRole()** - Gets the player's previous role if they are a Vampire that has been converted or `ROLE_NONE` otherwise.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsCustom()** - Whether the player's role is not one of the three default TTT roles.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsDetectiveLike()/plymeta:GetDetectiveLike()** - Whether the player's role is like a Detective (e.g. detective or promoted deputy/impersonator).\
*Realm:* Client and Server\
*Added in:* 1.0.0\

**plymeta:IsIndependentTeam()** - Whether the player is on the independent team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsInnocentTeam()** - Whether the player is on the innocent team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsJesterTeam()** - Whether the player is on the jester team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsMonsterTeam()** - Whether the player is on the monster team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsSameTeam(target)** - Whether the player is on the same team as the target.\
*Realm:* Client and Server\
*Added in:* 1.0.0\
*Parameters:*
- *target* - The other player whose team is being compared

**plymeta:IsShopRole()** - Whether the player has a shop (see `plymeta:CanUseShop` for determining if it is openable).\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsTraitorTeam()** - Whether the player is on the traitor team.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsVampireAlly()/plymeta:GetVampireAlly()** - Whether the player is allied with the vampire role.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsVampirePrime()/plymeta:GetVampirePrime()** - Whether the player is the prime (e.g. first-spawned) vampire.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsZombieAlly()/plymeta:GetZombieAlly()** - Whether the player is allied with the zombie role.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:IsZombiePrime()/plymeta:GetZombiePrime()** - Whether the player is the prime (e.g. first-spawned) zombie.\
*Realm:* Client and Server\
*Added in:* 1.0.0

**plymeta:MoveRoleState(target, keep_on_source)** - Moves role state data (such as promotion and monster prime status) to the target.\
*Realm:* Client and Server\
*Added in:* 1.0.5\
*Parameters:*
- *target* - The player to move the role state data to
- *keep_on_source* - Wheter the source player should also keep the role state data (Defaults to `false`)

**plymeta:SetRoleAndBroadcast(role)** - Sets the player's role to the given one and (if called on the server) broadcasts the change to all clients for scoreboard tracking.\
*Realm:* Client and Server\
*Added in:* 1.0.0\
*Parameters:*
- *role* - The role number to set this player to

**plymeta:SetVampirePreviousRole(previous_role)** - Sets the player's previous role for when they are turned into a vampire.\
*Realm:* Server\
*Added in:* 1.0.0\
*Parameters:*
- *previous_role* - The previous role this player had before becoming a vampire

**plymeta:SetVampirePrime(is_prime)** - Sets whether the player is a prime (e.g. first-spawned) vampire.\
*Realm:* Server\
*Added in:* 1.0.0\
*Parameters:*
- *is_prime* - Whether the player is a prime vampire

**plymeta:SetZombiePrime(is_prime)** - Sets whether the player is a prime (e.g. first-spawned) zombie.\
*Realm:* Server\
*Added in:* 1.0.0\
*Parameters:*
- *is_prime* - Whether the player is a prime zombie

**plymeta:StripRoleWeapons()** - Strips all weapons from the player whose `Category` property matches the global `WEAPON_CATEGORY_ROLE` value.\
*Realm:* Client and Server\
*Added in:* 1.0.5

## Hooks

**TTTCanIdentifyCorpse(ply, rag, was_traitor)** - Changed `was_traitor` parameter to be `true` for any member of the traitor team, rather than just the traitor role.\
*Realm:* Server\
*Added in:* 1.0.5\
*Parameters:*
- *ply* - The player who is attempting to identify a corpse
- *rag* - The ragdoll being identified
- *was_traitor* - Whether the player who the targetted ragdoll represents belonged to the traitor team

*Return:* Whether or not the given player should be able to identify the given corpse (Defaults to `false`).

**TTTPrintResultMessage(type)** - Called before the round win results message is printed to the top-right corner of the screen. Can be used to print a replacement message for custom win types that this would not normally handle.\
*Realm:* Server\
*Added in:* 1.0.14\
*Parameters:*
- *type* - The round win type

*Return:* `true` if the default print messages should be skipped (Defaults to `false`).

**TTTScoringWinTitle(wintype, wintitle, title)** - Called before the round summary screen is shown with the winning team. Return the win title object to use on the summary screen.\
*Realm:* Client\
*Added in:* 1.0.14\
*Parameters:*
- *wintype* - The round win type
- *wintitle* - Table of default win title parameters
- *title* - The currently selected win title

*Return:*
- *new_title*
  - *txt* - The translation string to use to get the winning team text
  - *c* - The background color to use
  - *params* - Any parameters to use when translating `txt` (Optional)

**TTTSelectRoles(choices, prev_roles)** - Called before players are randomly assigned roles. If a player is assigned a role during this hook, they will not be randomly assigned one later.\
*Realm:* Server\
*Added in:* 1.0.0\
*Parameters:*
- *choices* - The table of players who will be assigned roles
- *prev_roles* - The table whose keys are role numbers and values are tables of players who had that role last round

**TTTSprintStaminaPost(ply, stamina, sprint_timer, consumption)** - Called after a player's sprint stamina is reduced. Return value is the new stamina value for the player.\
*Realm:* Client\
*Added in:* 1.0.2\
*Parameters:*
- *ply* - Player whose stamina is being adjusted
- *stamina* - Player's currents stamina
- *sprint_timer* - Time representing when the player last sprinted
- *consumption* - The stamina consumption rate

*Return:* The stamina value to assign to the player. If none is provided, the player's stamina will not be changed.

## SWEPs
Changes made to SWEPs (the data structure used when defining new weapons)

### *SWEP Properties*

**SWEP.BlockShopRandomization** - Whether this weapon should block the shop randomization logic. Setting this to `true` will ensure this SWEP *always* shows in the applicable role's shop.\
*Added in:* 1.0.7

**SWEP.Category** - Updated so role weapons added by Custom Roles for TTT have a fixed global value: `WEAPON_CATEGORY_ROLE`. This is used to easily identify which weapons belong to specific roles.\
*Added in:* 1.0.5

**SWEP.EquipMenuData** - Updated so `name`, `type`, and `desc` properties can be parameterless functions to allow for parameterized translation.\
*Added in:* 1.0.8

## Commands

### *Client Commands*

**ttt_reset_weapons_cache** - Resets the client's equipment cache used in shop display. Useful when debugging changed shop rules.\
*Added in*: 1.0.11

### *Server Commands*

**ttt_kill_from_random** - Kills the local player by a random non-jester team player. *NOTE*: Cheats must be enabled to use this command.\
*Added in:* 1.0.0\
*Parameters:*
- *remove_body* - Whether to remove the local player's body after killing them (Defaults to `false`)

**ttt_kill_from_player** - Kills the local player by another player with the given name. *NOTE*: Cheats must be enabled to use this command.\
*Added in:* 1.0.0\
*Parameters:*
- *killer_name* - The name of the player who will kill the local player
- *remove_body* - Whether to remove the local player's body after killing them (Defaults to `false`)

**ttt_kill_target_from_random** - Kills the target player by a random non-jester team player. *NOTE*: Cheats must be enabled to use this command.\
*Added in:* 1.0.0\
*Parameters:*
- *target_name* - The name of the player who will be killed
- *remove_body* - Whether to remove the target player's body after killing them (Defaults to `false`)

**ttt_kill_target_from_player** - Kills the target player by another player with the given name. *NOTE*: Cheats must be enabled to use this command.\
*Added in:* 1.0.0\
*Parameters:*
- *target_name* - The name of the player who will be killed
- *killer_name* - The name of the player who will kill the target player
- *remove_body* - Whether to remove the target player's body after killing them (Defaults to `false`)

## Net Messages

**TTT_ResetBuyableWeaponsCache** - Resets the client's buyable weapons cache. This should be called if a weapon's CanBuy list has been updated.\
*Added in:* 1.0.0

**TTT_PlayerFootstep** - Adds a footstep to the list's list of footsteps to show.\
*Added in:* 1.0.0\
*Parameters:*
- *Entity* - The player whose footsteps are being recorded
- *Vector* - The position to place the footsteps at
- *Angle* - The angle to place the footsteps with
- *Bit* - Which foot's step is currently being recorded (0 = Left, 1 = Right)
- *Table* - The R, G, and B values of the color for the placed footstep
- *UInt(8)* - The amount of time (in seconds) before the footsteps should fade completely from view

**TTT_ClearPlayerFootsteps** - Resets the client's list of footsteps to show.\
*Added in:* 1.0.0

**TTT_UpdateRoleNames** - Causes the client to update their local role name tables based on convar values.\
*Added in:* 1.0.7