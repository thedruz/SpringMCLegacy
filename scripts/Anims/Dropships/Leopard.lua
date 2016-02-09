-- Unit-specific pieces only declared here, generic dropship pieces in main script
local body = piece ("body")
local cargoDoor1, cargoDoor2 = piece("cargodoor1", "cargodoor2")
local attachment = piece("attachment")

function Setup()
	-- Put pieces into starting pos
	for _, exhaust in ipairs(vExhaustLarges) do
		Turn(exhaust, x_axis, math.rad(89))
	end	
	for _, exhaust in ipairs(vExhausts) do
		Turn(exhaust, x_axis, math.rad(89))
	end	
	for _, exhaust in ipairs(hExhausts) do
		Turn(exhaust, y_axis, math.rad(180))
	end	
end

function LandingGearDown()
	Move(gears[1].gear, y_axis, -20, 3)
	for i = 2, 3 do
		Move(gears[i].gear, y_axis, -9, 1)
	end
	Turn(gears[1].gear, x_axis, math.rad(9), math.rad(3))
	WaitForMove(gears[1].gear, y_axis)
end

--[[function TouchDown()
end]]

function LandingGearUp()
	Move(gears[1].gear, y_axis, 0, 5)
	Turn(gears[1].gear, x_axis, 0, math.rad(3))
	for i = 2, 3 do
		Move(gears[i].gear, y_axis, 0, 2)
	end
	WaitForMove(gears[1].gear, y_axis)
end

--[[local fxStages = {

}]]

function fx()
	Signal(fx)
	SetSignalMask(fx)

	if stage == 0 then
		GG.EmitLupsSfx(unitID, "dropship_hull_heat", body, {repeatEffect = 3})
		GG.EmitLupsSfx(unitID, "dropship_hull_heat", body, {repeatEffect = 3, delay = 10})
		GG.EmitLupsSfx(unitID, "dropship_hull_heat", body, {repeatEffect = 2, delay = 20})
		for _, exhaust in ipairs(hExhaustLarges) do
			GG.EmitLupsSfx(unitID, "dropship_horizontal_jitter_strong", exhaust)
			GG.EmitLupsSfx(unitID, "dropship_horizontal_jitter_strong", exhaust, {delay = 20})
			GG.EmitLupsSfx(unitID, "dropship_horizontal_jitter_strong", exhaust, {delay = 40})
			GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust",  exhaust, {id = "hExhaustsJets", repeatEffect = true, width = 30, length = 150})
		end
		for _, exhaust in ipairs(vExhaustLarges) do
			GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "vExhaustsLargesJets", width = 65, length = 115})
		end
		for _, exhaust in ipairs(vExhausts) do
			GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "vExhaustsJets", width = 50, length = 95})
		end
	end
	while stage == 0 do
		Sleep(30)
	end
	if stage == 1 then
		GG.RemoveLupsSfx(unitID, "vExhaustsJets")
		GG.RemoveLupsSfx(unitID, "vExhaustsLargesJets")
		for _, exhaust in ipairs(hExhaustLarges) do
			GG.EmitLupsSfx(unitID, "dropship_horizontal_jitter_weak", exhaust)
			GG.EmitLupsSfx(unitID, "dropship_horizontal_jitter_weak", exhaust, {delay = 20})
			GG.EmitLupsSfx(unitID, "dropship_horizontal_jitter_weak", exhaust, {delay = 40})
		end
		for _, exhaust in ipairs(vExhaustLarges) do
			GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "vExhaustsLargesJets", replace = true, width = 40, length = 90})
		end
		for _, exhaust in ipairs(vExhausts) do
			GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "vExhaustsJets", width = 25, length = 70})
		end
	end
	while stage == 1 do
		Sleep(30)
	end
	if stage == 2 then
		GG.RemoveLupsSfx(unitID, "hExhaustsJets")
		for _, exhaust in ipairs(hExhaustLarges) do
			GG.BlendJet(99, unitID, exhaust, "hExhaustsJets")
		end
	end
	while stage == 2 do
		Sleep(30)
	end
	if stage == 3 then
		GG.RemoveLupsSfx(unitID, "vExhaustsJets")
		GG.RemoveLupsSfx(unitID, "vExhaustsLargesJets")
		for _, exhaust in ipairs(vExhausts) do
			GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "vExhaustsJets"})
		end
		GG.EmitLupsSfx(unitID, "exhaust_ground_winds", body, {repeatEffect = 4, delay = 125})
		GG.EmitLupsSfx(unitID, "exhaust_ground_winds", body, {repeatEffect = 4, delay = 125 + 80})
	end
	while stage == 3 do
		--SpawnCEG("dropship_heavy_dust", TX, TY, TZ)
		Sleep(30)
	end
	if stage == 4 then
		GG.RemoveLupsSfx(unitID, "hExhaustsJets")
		GG.RemoveLupsSfx(unitID, "vExhaustsJets")
		GG.RemoveLupsSfx(unitID, "vExhaustsLargeJets")
		for _, exhaust in ipairs(hExhaustLarges) do
			GG.EmitLupsSfx(unitID, "dropship_horizontal_jitter_strong", exhaust)
			GG.EmitLupsSfx(unitID, "dropship_horizontal_jitter_strong", exhaust, {delay = 20})
			GG.EmitLupsSfx(unitID, "dropship_horizontal_jitter_strong", exhaust, {delay = 40})
		end
		local time = 114
		for t = 0, (time/3) do
			local i = t / (time/3)
			for _, exhaust in ipairs(hExhaustLarges) do
				if (i == 1) then
					GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "hExhaustsJets", repeatEffect = true, delay = t*3, width = 110, length = 350})
				elseif (i > 0.33) then
					GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "hExhaustsJets", life = 2, delay = t*3, width = i * 110, length = i * 350})
					GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "hExhaustsJets", life = 1, delay = t*3+2, width = i * 100, length = i * 300})
				else
					GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "hExhaustsJets", life = 1, delay = t*3,   width = i * 110, length = i * 350})
					GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "hExhaustsJets", life = 2, delay = t*3+1, width = i * 80, length = i * 190})
				end
			end
		end
		for _, exhaust in ipairs(vExhaustLarges) do
			GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "vExhaustsLargesJets", length = 80, width = 45})
		end
		for i, exhaust in ipairs(vExhausts) do
			if (i % 2 == 1) then
				GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "vExhaustsJets", length = 85, width = 55})
			else
				GG.EmitLupsSfx(unitID, "dropship_vertical_exhaust", exhaust, {id = "vExhaustsJets"})
			end
		end
	end
	while stage == 4 do
		Sleep(30)
	end
	if stage == 5 then
		GG.RemoveLupsSfx(unitID, "vExhaustsLargesJets")
		GG.RemoveLupsSfx(unitID, "vExhaustsJets")
	end
	while stage == 5 do
		for _, exhaust in ipairs(hExhaustLarges) do
			EmitSfx(exhaust, SFX.CEG + 2)
			EmitSfx(exhaust, SFX.CEG + 3)
		end
		Sleep(30)
	end
end

doors = {}
links = {}
for i = 1,4 do
	doors[i] = piece("door" .. i)
	links[i] = piece("link" .. i)
end

function TakeOff()
	LandingGearUp()
	stage = 4
	--Spring.MoveCtrl.SetRelativeVelocity(unitID, 0, 0, 5)
	Spring.MoveCtrl.SetRelativeVelocity(unitID, 0, 0, 5)
	Spring.MoveCtrl.SetGravity(unitID, -0.75 * GRAVITY)
	Turn(body, x_axis, math.rad(-30), math.rad(10))
	WaitForTurn(body, x_axis)
	Turn(body, x_axis, math.rad(-70), math.rad(15))
	WaitForTurn(body, x_axis)
	Turn(body, x_axis, math.rad(-80), math.rad(5))
	WaitForTurn(body, x_axis)
	Spring.MoveCtrl.SetGravity(unitID, -4 * GRAVITY)
	stage = 5
	Sleep(1500)
	Spin(body, z_axis, math.rad(180), math.rad(45))
	Sleep(2000)
	StopSpin(body, z_axis, math.rad(45))
	Sleep(2000)
	-- We're out of the atmosphere, bye bye!
	Spring.DestroyUnit(unitID, false, true)
end

local WAIT_TIME = 10000
local DOOR_SPEED = math.rad(20)
local x, _ ,z = Spring.GetUnitPosition(unitID)
--local dx, _, dz = Spring.GetUnitDirection(unitID)
local dirAngle = HEADING / 2^16 * 2 * math.pi
local dx = math.sin(dirAngle)
local dz = math.cos(dirAngle)
local UNLOAD_X = x + 300 * dx
local UNLOAD_Z = z + 300 * dz

local cargoLeft

function UnloadMech(i)
	Signal(i + 1)
	SetSignalMask(i + 1)
	Spring.Echo("unload mech", i)
	env = Spring.UnitScript.GetScriptEnv(cargo[i])
	if env and env.script and env.script.StartMoving then -- TODO: shouldn't be required, maybe if cargo died?
		Spring.UnitScript.CallAsUnit(cargo[i], env.script.StartMoving, false)
	end
	local currUnitDef = UnitDefs[Spring.GetUnitDefID(cargo[i])]
	local moveSpeed = currUnitDef.speed * 0.25
	-- Move to the ramp
	Move(links[i], x_axis, (i <= 2 and 1 or -1) * 50, moveSpeed)
	Spring.Echo("unload mech move links", i)
	Sleep(20)
	WaitForMove(links[i], x_axis)
	Sleep(20)
	Spring.Echo("unload mech waitformove 1", i)
	-- We already moved to the edge, proceed down the ramp
	Move(cargoPieces[i], z_axis, (i <= 2 and -1 or 1) and 75, moveSpeed) -- 65
	WaitForMove(cargoPieces[i], z_axis)
	Spring.Echo("unload mech waitformove 2", i)
	Spring.UnitScript.DropUnit(cargo[i])
	Spring.Echo("unload mech dropunit", i )
	if cargoLeft == 1 then
		Spring.UnitScript.DropUnit(cargo[i])
	end
	Spring.SetUnitBlocking(cargo[i], true, true, true, true, true, true, true)
	-- TODO: change bugout depending on side of leopard
	Spring.SetUnitMoveGoal(cargo[i], UNLOAD_X +  math.random(-100, 100), 0, UNLOAD_Z +  math.random(-100, 100), 25) -- bug out over here
	cargoLeft = cargoLeft - 1
	Spring.Echo("CARGO LEFT", cargoLeft)
	Sleep(1000)
	Turn(doors[i], z_axis, 0, DOOR_SPEED)
	WaitForTurn(doors[i], z_axis)
	if cargoLeft == 0 then -- This was the last mech out
		Spring.Echo("Last one out!")
		Sleep(2000)
		TakeOff()
	end
end

function UnloadCargo()
	cargoLeft = numCargo
	for i = 1, numCargo do
		Turn(links[i], y_axis, (i <= 2 and 1 or -1) * math.rad(90))
		Turn(doors[i], z_axis, (i <= 2 and -1 or 1) * math.rad(140), DOOR_SPEED)
	end
	WaitForTurn(doors[numCargo], z_axis)
	for i = 1, numCargo do
		Turn(links[i], x_axis, (i <= 2 and 1 or -1) * math.rad(20))
		Turn(cargoPieces[i], x_axis, (i <= 2 and -1 or 1) * math.rad(20))
	end
	for i = 1, numCargo do
		StartThread(UnloadMech, i)
	end	
end

function Drop()
	-- Move us up to the drop position
	Spring.MoveCtrl.Enable(unitID)
	Spring.MoveCtrl.SetPosition(unitID, TX + UX, TY + DROP_HEIGHT, TZ + UZ)
	local newAngle = math.atan2(UX, UZ)
	Spring.MoveCtrl.SetRotation(unitID, 0, newAngle + math.pi, 0)
	Turn(body, x_axis, math.rad(-50))
	-- Begin the drop
	GG.PlaySoundForTeam(teamID, "BB_Dropship_Inbound", 1)
	Turn(body, x_axis, math.rad(-10), math.rad(5))
	Spring.MoveCtrl.SetVelocity(unitID, 0, -100, 0)
	Spring.MoveCtrl.SetRelativeVelocity(unitID, 0, 0, 10)
	Spring.MoveCtrl.SetGravity(unitID, -3.78 * GRAVITY)
	local x, y, z = Spring.GetUnitPosition(unitID)
	while y - TY > 150 + HOVER_HEIGHT do
		x, y, z = Spring.GetUnitPosition(unitID)
		local newAngle = math.atan2(x - TX, z - TZ)
		Spring.MoveCtrl.SetRotation(unitID, 0, newAngle + math.pi, 0)
		if (y - TY) < 4 * HOVER_HEIGHT and stage == 0 then
			stage = 1
			StartThread(fx)
		elseif (y - TY) < 3 * HOVER_HEIGHT and stage == 1 then
			stage = 2
		end
		Sleep(100)
	end
	-- Descent complete, move over the target
	StartThread(LandingGearDown)
	Turn(body, x_axis, 0, math.rad(3.5))
	Spring.MoveCtrl.SetVelocity(unitID, 0, 0, 0)
	Spring.MoveCtrl.SetGravity(unitID, 0)
	local dist = GetUnitDistanceToPoint(unitID, TX, 0, TZ, false)
	while dist > 1 do
		dist = GetUnitDistanceToPoint(unitID, TX, 0, TZ, false)
		--Spring.Echo("dist", dist)
		Spring.MoveCtrl.SetRelativeVelocity(unitID, 0, 0, math.max(dist/50, 2))
		Sleep(30)
	end
	-- only proceed if the beacon is still ours and is secure
	--if Spring.GetUnitTeam(beaconID) == Spring.GetUnitTeam(unitID) and Spring.GetUnitRulesParam(beaconID, "secure") == 1 then
		-- We're over the target area, reduce height!
		stage = 3
		local vertSpeed = 4
		local wantedHeight = GY
		local dist = select(2, Spring.GetUnitPosition(unitID)) - GY
		while (dist > 0) do
			Spring.MoveCtrl.SetRelativeVelocity(unitID, 0, -math.max(0.275, vertSpeed * dist/300), 0)
			Sleep(10)
			dist = select(2, Spring.GetUnitPosition(unitID)) - wantedHeight
		end
		-- We're in place. Halt and lower the cargo!
		Spring.MoveCtrl.SetRelativeVelocity(unitID, 0, 0, 0)
		UnloadCargo()
	--else -- bugging out, refund
		--Spring.AddTeamResource(teamID, "metal", UnitDefs[Spring.GetUnitDefID(cargo[1])].metalCost)
	--end
end