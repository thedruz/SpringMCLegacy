-- Test Mech Script
-- useful global stuff
local ud = UnitDefs[Spring.GetUnitDefID(unitID)] -- unitID is available automatically to all LUS
local weapons = ud.weapons
local deg, rad = math.deg, math.rad

--piece defines
local pelvis, torso = piece ("pelvis", "torso")
local rupperarm, rlowerarm, lupperarm, llowerarm = piece ("rupperarm", "rlowerarm", "lupperarm", "llowerarm")
local lupperleg, llowerleg, rupperleg, rlowerleg, rfronttoe, rbacktoe, lfronttoe, lbacktoe = piece ("lupperleg", "llowerleg", "rupperleg", "rlowerleg", "rfronttoe", "rbacktoe", "lfronttoe", "lbacktoe")
local flare1, flare2, flare3 = piece ("flare1", "flare2", "flare3")
local jet1, jet2, jet3, jet4 = piece ("jet1", "jet2", "jet3", "jet4")

local missileWeaponIDs = {[4] = true}
 
local launchPoints = {}
local numPoints = {}
local currPoints = {}
 
--Turning/Movement Locals
local TORSO_SPEED = rad(160)
local ELEVATION_SPEED = rad(200)
local LEG_SPEED = rad(750)

for weaponID in pairs(missileWeaponIDs) do
        launchPoints[weaponID] = {}
        currPoints[weaponID] = 1
        numPoints[weaponID] = WeaponDefs[weapons[weaponID].weaponDef].salvoSize
        for i = 1, numPoints[weaponID] do
                launchPoints[weaponID][i] = piece("launchpoint_" .. weaponID .. "_" .. i)
        end
end
local currLaunchPoint = 1

-- constants
local SIG_AIM = 2
local walking = false
local RESTORE_DELAY = Spring.UnitScript.GetLongestReloadTime(unitID) * 2

-- includes
include "smokeunit.lua"

--SFX defines
MEDIUM_MUZZLEFLASH = SFX.CEG+0
MG_MUZZLEFLASH = SFX.CEG+1
RocketTrail = SFX.CEG+2

local function MotionControl()
	while true do
		if walking then
			--Spring.Echo("Step ONE")
			--Left Leg--
			Turn(lupperleg, x_axis, rad(25), LEG_SPEED)
			Turn(llowerleg, x_axis, rad(25), LEG_SPEED)
			Turn(lbacktoe, x_axis, rad(-60), LEG_SPEED)
			Turn(lfronttoe, x_axis, rad(-15), LEG_SPEED)
			--Right Leg--
			Turn(rupperleg, x_axis, rad(-25), LEG_SPEED)
			Turn(rlowerleg, x_axis, rad(15), LEG_SPEED)
			Turn(rbacktoe, x_axis, rad(-30), LEG_SPEED)
			Turn(rfronttoe, x_axis, rad(45), LEG_SPEED)
			--Wait For Turns...--
			WaitForTurn(lupperleg, x_axis)
			WaitForTurn(llowerleg, x_axis)
			WaitForTurn(lbacktoe, x_axis)
			WaitForTurn(lfronttoe, x_axis)
			WaitForTurn(rupperleg, x_axis)
			WaitForTurn(rlowerleg, x_axis)
			WaitForTurn(rbacktoe, x_axis)
			WaitForTurn(rfronttoe, x_axis)
			Sleep(10)
			--Spring.Echo("Step TWO")
			--Left Leg--
			Turn(lupperleg, x_axis, rad(25), LEG_SPEED)
			Turn(llowerleg, x_axis, rad(45), LEG_SPEED)
			Turn(lbacktoe, x_axis, rad(-75), LEG_SPEED)
			Turn(lfronttoe, x_axis, rad(-60), LEG_SPEED)
			--Right Leg--
			Turn(rupperleg, x_axis, rad(-45), LEG_SPEED)
			Turn(rlowerleg, x_axis, rad(0), LEG_SPEED)
			Turn(rbacktoe, x_axis, rad(-30), LEG_SPEED)
			Turn(rfronttoe, x_axis, rad(40), LEG_SPEED)
			--Wait For Turns...--
			WaitForTurn(lupperleg, x_axis)
			WaitForTurn(llowerleg, x_axis)
			WaitForTurn(lbacktoe, x_axis)
			WaitForTurn(lfronttoe, x_axis)
			WaitForTurn(rupperleg, x_axis)
			WaitForTurn(rlowerleg, x_axis)
			WaitForTurn(rbacktoe, x_axis)
			WaitForTurn(rfronttoe, x_axis)
			Sleep(10)
			--Spring.Echo("Step THREE")
			--Left Leg--
			Turn(lupperleg, x_axis, rad(60), LEG_SPEED)
			Turn(llowerleg, x_axis, rad(15), LEG_SPEED)
			Turn(lbacktoe, x_axis, rad(-45), LEG_SPEED)
			Turn(lfronttoe, x_axis, rad(0), LEG_SPEED)
			--Right Leg--
			Turn(rupperleg, x_axis, rad(-30), LEG_SPEED)
			Turn(rlowerleg, x_axis, rad(15), LEG_SPEED)
			Turn(rbacktoe, x_axis, rad(10), LEG_SPEED)
			Turn(rfronttoe, x_axis, rad(15), LEG_SPEED)
			--Wait For Turns...--
			WaitForTurn(lupperleg, x_axis)
			WaitForTurn(llowerleg, x_axis)
			WaitForTurn(lbacktoe, x_axis)
			WaitForTurn(lfronttoe, x_axis)
			WaitForTurn(rupperleg, x_axis)
			WaitForTurn(rlowerleg, x_axis)
			WaitForTurn(rbacktoe, x_axis)
			WaitForTurn(rfronttoe, x_axis)
			Sleep(10)
			--Spring.Echo("Step FOUR")
			--Left Leg--
			Turn(lupperleg, x_axis, rad(-10), LEG_SPEED)
			Turn(llowerleg, x_axis, rad(-15), LEG_SPEED)
			Turn(lbacktoe, x_axis, rad(-45), LEG_SPEED)
			Turn(lfronttoe, x_axis, rad(30), LEG_SPEED)
			--Right Leg--
			Turn(rupperleg, x_axis, rad(0), LEG_SPEED)
			Turn(rlowerleg, x_axis, rad(5), LEG_SPEED)
			Turn(rbacktoe, x_axis, rad(0), LEG_SPEED)
			Turn(rfronttoe, x_axis, rad(0), LEG_SPEED)
			--Wait For Turns...--
			WaitForTurn(lupperleg, x_axis)
			WaitForTurn(llowerleg, x_axis)
			WaitForTurn(lbacktoe, x_axis)
			WaitForTurn(lfronttoe, x_axis)
			WaitForTurn(rupperleg, x_axis)
			WaitForTurn(rlowerleg, x_axis)
			WaitForTurn(rbacktoe, x_axis)
			WaitForTurn(rfronttoe, x_axis)
			Sleep(10)
			--Spring.Echo("Step FIVE")
			--Left Leg--
			Turn(lupperleg, x_axis, rad(-25), LEG_SPEED)
			Turn(llowerleg, x_axis, rad(-15), LEG_SPEED)
			Turn(lbacktoe, x_axis, rad(-30), LEG_SPEED)
			Turn(lfronttoe, x_axis, rad(45), LEG_SPEED)
			--Right Leg--
			Turn(rupperleg, x_axis, rad(25), LEG_SPEED)
			Turn(rlowerleg, x_axis, rad(25), LEG_SPEED)
			Turn(rbacktoe, x_axis, rad(-60), LEG_SPEED)
			Turn(rfronttoe, x_axis, rad(-45), LEG_SPEED)
			--Wait For Turns...--
			WaitForTurn(lupperleg, x_axis)
			WaitForTurn(llowerleg, x_axis)
			WaitForTurn(lbacktoe, x_axis)
			WaitForTurn(lfronttoe, x_axis)
			WaitForTurn(rupperleg, x_axis)
			WaitForTurn(rlowerleg, x_axis)
			WaitForTurn(rbacktoe, x_axis)
			WaitForTurn(rfronttoe, x_axis)
			Sleep(10)
			--Spring.Echo("Step SIX")
			--Left Leg--
			Turn(lupperleg, x_axis, rad(-45), LEG_SPEED)
			Turn(llowerleg, x_axis, rad(0), LEG_SPEED)
			Turn(lbacktoe, x_axis, rad(-30), LEG_SPEED)
			Turn(lfronttoe, x_axis, rad(60), LEG_SPEED)
			--Right Leg--
			Turn(rupperleg, x_axis, rad(25), LEG_SPEED)
			Turn(rlowerleg, x_axis, rad(45), LEG_SPEED)
			Turn(rbacktoe, x_axis, rad(-75), LEG_SPEED)
			Turn(rfronttoe, x_axis, rad(-60), LEG_SPEED)
			--Wait For Turns...--
			WaitForTurn(lupperleg, x_axis)
			WaitForTurn(llowerleg, x_axis)
			WaitForTurn(lbacktoe, x_axis)
			WaitForTurn(lfronttoe, x_axis)
			WaitForTurn(rupperleg, x_axis)
			WaitForTurn(rlowerleg, x_axis)
			WaitForTurn(rbacktoe, x_axis)
			WaitForTurn(rfronttoe, x_axis)
			Sleep(10)
			--Spring.Echo("Step SEVEN")
			--Left Leg--
			Turn(lupperleg, x_axis, rad(-30), LEG_SPEED)
			Turn(llowerleg, x_axis, rad(15), LEG_SPEED)
			Turn(lbacktoe, x_axis, rad(10), LEG_SPEED)
			Turn(lfronttoe, x_axis, rad(15), LEG_SPEED)
			--Right Leg--
			Turn(rupperleg, x_axis, rad(45), LEG_SPEED)
			Turn(rlowerleg, x_axis, rad(15), LEG_SPEED)
			Turn(rbacktoe, x_axis, rad(-45), LEG_SPEED)
			Turn(rfronttoe, x_axis, rad(0), LEG_SPEED)
			--Wait For Turns...--
			WaitForTurn(lupperleg, x_axis)
			WaitForTurn(llowerleg, x_axis)
			WaitForTurn(lbacktoe, x_axis)
			WaitForTurn(lfronttoe, x_axis)
			WaitForTurn(rupperleg, x_axis)
			WaitForTurn(rlowerleg, x_axis)
			WaitForTurn(rbacktoe, x_axis)
			WaitForTurn(rfronttoe, x_axis)
			Sleep(10)
			--Spring.Echo("Step EIGHT")
			--Left Leg--
			Turn(lupperleg, x_axis, rad(0), LEG_SPEED)
			Turn(llowerleg, x_axis, rad(5), LEG_SPEED)
			Turn(lbacktoe, x_axis, rad(0), LEG_SPEED)
			Turn(lfronttoe, x_axis, rad(0), LEG_SPEED)
			--Right Leg--
			Turn(rupperleg, x_axis, rad(-10), LEG_SPEED)
			Turn(rlowerleg, x_axis, rad(-15), LEG_SPEED)
			Turn(rbacktoe, x_axis, rad(-45), LEG_SPEED)
			Turn(rfronttoe, x_axis, rad(30), LEG_SPEED)
			--Wait For Turns...--
			WaitForTurn(lupperleg, x_axis)
			WaitForTurn(llowerleg, x_axis)
			WaitForTurn(lbacktoe, x_axis)
			WaitForTurn(lfronttoe, x_axis)
			WaitForTurn(rupperleg, x_axis)
			WaitForTurn(rlowerleg, x_axis)
			WaitForTurn(rbacktoe, x_axis)
			WaitForTurn(rfronttoe, x_axis)
			Sleep(10)
		else
			Turn(lupperleg, x_axis, rad(0), LEG_SPEED)
			Turn(llowerleg, x_axis, rad(0), LEG_SPEED)
			Turn(lfronttoe, x_axis, rad(0), LEG_SPEED)
			Turn(lbacktoe, x_axis, rad(0), LEG_SPEED)
			Turn(rupperleg, x_axis, rad(0), LEG_SPEED)
			Turn(rlowerleg, x_axis, rad(0), LEG_SPEED)
			Turn(rfronttoe, x_axis, rad(0), LEG_SPEED)
			Turn(rbacktoe, x_axis, rad(0),LEG_SPEED)
			Sleep(100)
		end
	end
end


--local function StopWalk()
--	Turn(lupperleg, x_axis, 0, rad(200))
--	Turn(rupperleg, x_axis, 0, rad(200))
--end

function script.Create()
	StartThread(SmokeUnit, {pelvis, torso})
	StartThread(MotionControl)
end

function script.StartMoving()
	walking = true
end

function script.StopMoving()
	walking = false
end

function script.Activate()
	Spring.SetUnitStealth(unitID, false)
end

function beginJump()
	EmitSfx(jet1, RocketTrail)
	EmitSfx(jet2, RocketTrail)
	EmitSfx(jet3, RocketTrail)
	EmitSfx(jet4, RocketTrail)
end

function script.Deactivate()
	Spring.SetUnitStealth(unitID, true)
end

local function RestoreAfterDelay(unitID)
	Sleep(RESTORE_DELAY)
	Turn(torso, y_axis, 0, TORSO_SPEED)
	Turn(llowerarm, x_axis, 0, ELEVATION_SPEED)
	Turn(rlowerarm, x_axis, 0, ELEVATION_SPEED)
end

function script.AimWeapon(weaponID, heading, pitch)
	Signal(SIG_AIM ^ weaponID) -- 2 'to the power of' weapon ID
    SetSignalMask(SIG_AIM ^ weaponID)
		if weaponID == 1 then
			Turn(rlowerarm, x_axis, -pitch, ELEVATION_SPEED)
		elseif weaponID == 2 then
			Turn(llowerarm, x_axis, -pitch, ELEVATION_SPEED)
		--elseif weaponID == 2 then
		--	Turn(launcher1, x_axis, -pitch, rad(150))
		--elseif weaponID == 3 then
		--	Turn(launcher2, x_axis, -pitch, rad(150))
		end
	Turn(torso, y_axis, heading, TORSO_SPEED)
	WaitForTurn(torso, y_axis)
	StartThread(RestoreAfterDelay)
	return true
end

function script.FireWeapon(weaponID)
		if weaponID == 1 then
			EmitSfx(flare1, MG_MUZZLEFLASH)
		elseif weaponID == 2 then
			EmitSfx(flare2, MG_MUZZLEFLASH)
		elseif weaponID == 3 then
			EmitSfx(flare3, MG_MUZZLEFLASH)
		end
end

function script.Shot(weaponID)
	if missileWeaponIDs[weaponID] then
		EmitSfx(launchPoints[weaponID][currPoints[weaponID]], MEDIUM_MUZZLEFLASH)
        currPoints[weaponID] = currPoints[weaponID] + 1
        if currPoints[weaponID] > numPoints[weaponID] then 
                currPoints[weaponID] = 1
        end
	end		
end

function script.AimFromWeapon(weaponID) 
	return torso
end

function script.QueryWeapon(weaponID) 
	if missileWeaponIDs[weaponID] then
		return launchPoints[weaponID][currPoints[weaponID]]
	else
		if weaponID == 1 then
			return flare1
		elseif weaponID == 2 then
			return flare2
		elseif weaponID == 3 then
			return flare3
		end
	end
end

function script.Killed(recentDamage, maxHealth)
	--local severity = recentDamage / maxHealth * 100
	--if severity <= 25 then
	--	Explode(body, math.bit_or({SFX.BITMAPONLY, SFX.BITMAP1}))
	--	return 1
	--elseif severity <= 50 then
	--	Explode(body, math.bit_or({SFX.FALL, SFX.BITMAP1}))
	--	return 2
	--else
	--	Explode(body, math.bit_or({SFX.FALL, SFX.SMOKE, SFX.FIRE, SFX.EXPLODE_ON_HIT, SFX.BITMAP1}))
	--	return 3
	--end
end
