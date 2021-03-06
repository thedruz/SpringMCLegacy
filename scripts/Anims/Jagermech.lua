--piece defines
-- NB. local here means main script can't read them, may want to change that for e.g. Killed (or put Killed in here for per-unit death anims! But then other pieces need to be none-local)
local pelvis, torso, lupperleg, llowerleg, rupperleg, rlowerleg, lfoot, rfoot = piece ("pelvis", "torso", "lupperleg", "llowerleg", "rupperleg", "rlowerleg", "lfoot", "rfoot")
local rupperarm, lupperarm = piece ("rupperarm", "lupperarm")

--Turning/Movement Locals
local LEG_SPEED = rad(200) * speedMod
local LEG_TURN_SPEED = rad (300) * speedMod

function anim_Turn(clockwise)
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
	while true do
--		Spring.Echo("anim_Turn")
		--Left Leg Up...
		Turn(pelvis, z_axis, rad(-5), LEG_TURN_SPEED / 2)
		Turn(lupperleg, x_axis, rad(-40), LEG_TURN_SPEED / 1.5)
		Turn(llowerleg, x_axis, rad(60), LEG_TURN_SPEED)
		--Wait for turns...
		WaitForTurn(pelvis, z_axis)
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		--Left Leg Down...
		Turn(pelvis, z_axis, rad(0), LEG_TURN_SPEED)
		Turn(lupperleg, x_axis, rad(0), LEG_TURN_SPEED / 1.5)
		Turn(llowerleg, x_axis, rad(0), LEG_TURN_SPEED)
		--Wait for turns...
		WaitForTurn(pelvis, z_axis)
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		PlaySound("stomp")
		--Right Leg Up...
		Turn(pelvis, z_axis, rad(5), LEG_TURN_SPEED / 2)
		Turn(rupperleg, x_axis, rad(-40), LEG_TURN_SPEED / 1.5)
		Turn(rlowerleg, x_axis, rad(60), LEG_TURN_SPEED)
		--Wait for turns...
		WaitForTurn(pelvis, z_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		--Right Leg Down...
		Turn(pelvis, z_axis, rad(0), LEG_TURN_SPEED / 2)
		Turn(rupperleg, x_axis, rad(0), LEG_TURN_SPEED / 1.5)
		Turn(rlowerleg, x_axis, rad(0), LEG_TURN_SPEED)
		--Wait for turns
		WaitForTurn(pelvis, z_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		PlaySound("stomp")
	end
end

-- Walk script
function anim_Walk()
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
	while true do
--		Spring.Echo("anim_Walk")
		--Spring.Echo("Step 1")
		--Pelvis--
		Move(pelvis, y_axis, -0.5, LEG_SPEED)
		Turn(pelvis, z_axis, rad(-1), LEG_SPEED)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(20), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-5), LEG_SPEED)
		Turn(lfoot, x_axis, rad(-10), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-65), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(70), LEG_SPEED)
		Turn(rfoot, x_axis, rad(0), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		
		--Spring.Echo("Step 2")
		--Arms--
		Move(lupperarm, y_axis, -5, LEG_SPEED)
		Move(rupperarm, y_axis, -5, LEG_SPEED)
		--Pelvis--
		Move(pelvis, y_axis, -1, LEG_SPEED)
		Turn(pelvis, z_axis, rad(-3), LEG_SPEED)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(25), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(30), LEG_SPEED)
		Turn(lfoot, x_axis, rad(-5), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-20), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(5), LEG_SPEED)
		Turn(rfoot, x_axis, rad(15), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		
		--Spring.Echo("Step 3")
		--Arms--
		Move(lupperarm, y_axis, 0, LEG_SPEED)
		Move(rupperarm, y_axis, 0, LEG_SPEED)
		--Pelvis--
		Move(pelvis, y_axis, 0, LEG_SPEED)
		Turn(pelvis, z_axis, rad(0), LEG_SPEED)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-10), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(65), LEG_SPEED)
		Turn(lfoot, x_axis, rad(-5), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(0), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(0), LEG_SPEED)
		Turn(rfoot, x_axis, rad(0), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		
		--Spring.Echo("Step 4")
		--Pelvis--
		Move(pelvis, y_axis, -0.5, LEG_SPEED)
		Turn(pelvis, z_axis, rad(1), LEG_SPEED)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-65), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(70), LEG_SPEED)
		Turn(lfoot, x_axis, rad(0), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(20), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(-5), LEG_SPEED)
		Turn(rfoot, x_axis, rad(-10), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		
		--Spring.Echo("Step 5")
		--Arms--
		Move(lupperarm, y_axis, -5, LEG_SPEED)
		Move(rupperarm, y_axis, -5, LEG_SPEED)
		--Pelvis--
		Move(pelvis, y_axis, -1, LEG_SPEED)
		Turn(pelvis, z_axis, rad(3), LEG_SPEED)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-20), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(5), LEG_SPEED)
		Turn(lfoot, x_axis, rad(15), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(25), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(30), LEG_SPEED)
		Turn(rfoot, x_axis, rad(-5), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		
		--Spring.Echo("Step 6")
		--Arms--
		Move(lupperarm, y_axis, 0, LEG_SPEED)
		Move(rupperarm, y_axis, 0, LEG_SPEED)
		--Pelvis--
		Move(pelvis, y_axis, 0, LEG_SPEED)
		Turn(pelvis, z_axis, rad(0), LEG_SPEED)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(0), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-5), LEG_SPEED)
		Turn(lfoot, x_axis, rad(5), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(0), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(55), LEG_SPEED)
		Turn(rfoot, x_axis, rad(-5), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
	end
end

function anim_Reset()
	Signal(SIG_ANIMATE)
--	Spring.Echo("anim_Reset")
	Turn(pelvis, z_axis, rad(0), LEG_SPEED)
	Turn(lupperleg, x_axis, rad(0), LEG_SPEED)
	Turn(llowerleg, x_axis, rad(0), LEG_SPEED)
	Turn(lfoot, x_axis, rad(0), LEG_SPEED)
	Turn(rupperleg, x_axis, rad(0), LEG_SPEED)
	Turn(rlowerleg, x_axis, rad(0), LEG_SPEED)
	Turn(rfoot, x_axis, rad(0), LEG_SPEED)
	Move(lupperarm, y_axis, 0, LEG_SPEED)
	Move(rupperarm, y_axis, 0, LEG_SPEED)
	PlaySound("stomp")
	Sleep(100)
end