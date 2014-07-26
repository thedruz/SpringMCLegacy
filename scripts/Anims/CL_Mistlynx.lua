--piece defines
-- NB. local here means main script can't read them, may want to change that for e.g. Killed (or put Killed in here for per-unit death anims! But then other pieces need to be none-local)
local pelvis, lupperleg, llowerleg, rupperleg, rlowerleg, rtoe, ltoe = piece ("pelvis", "lupperleg", "llowerleg", "rupperleg", "rlowerleg", "rtoe", "ltoe")

--Turning/Movement Locals
local LEG_SPEED = rad(900)
local LEG_TURN_SPEED = rad (300)

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

function anim_PreJump()
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
--	Spring.Echo("anim_PreJump")
	anim_Reset()
		--Crouch...
		Turn(rupperleg, x_axis, rad(-30), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(30), LEG_SPEED)
		Turn(lupperleg, x_axis, rad(-30), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(30), LEG_SPEED)
		--Move(pelvis, y_axis, -7.6, LEG_SPEED * 8)
		Move(pelvis, z_axis, -4.3, LEG_SPEED * 8)
		--Hold a bit...
		Sleep(100)
		--Wait for turns...
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
--	Spring.Echo("anim_PreJump Completed")
end

function anim_StartJump()
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
--	Spring.Echo("anim_StartJump")
		--Jump!
		Turn(rupperleg, x_axis, rad(5), LEG_SPEED * 4)
		Turn(rlowerleg, x_axis, rad(20), LEG_SPEED * 4)
		Turn(rtoe, x_axis, rad(15), LEG_SPEED * 4)
		Turn(lupperleg, x_axis, rad(5), LEG_SPEED * 4)
		Turn(llowerleg, x_axis, rad(20), LEG_SPEED * 4)
		Turn(ltoe, x_axis, rad(15), LEG_SPEED * 4)
		Move(pelvis, y_axis, 0, LEG_SPEED * 4)
		Move(pelvis, z_axis, 0, LEG_SPEED * 4)
		--Wait for turns...
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(ltoe, x_axis)
--	Spring.Echo("anim_StartJump Completed")
end

function anim_HalfJump()
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
--	Spring.Echo("anim_HalfJump")
		--Brace for impact...
		Turn(rupperleg, x_axis, rad(-30), LEG_SPEED / 4)
		Turn(rlowerleg, x_axis, rad(20), LEG_SPEED / 4)
		Turn(rtoe, x_axis, rad(-10), LEG_SPEED / 4)
		Turn(lupperleg, x_axis, rad(-30), LEG_SPEED / 4)
		Turn(llowerleg, x_axis, rad(20), LEG_SPEED / 4)
		Turn(ltoe, x_axis, rad(-10), LEG_SPEED / 4)
		--WaitForTurns...
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(ltoe, x_axis)
		WaitForTurn(llowerleg, x_axis)
--	Spring.Echo("anim_HalfJump Completed")
end

function anim_StopJump()
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
--	Spring.Echo("anim_StopJump")
		--Touchdown!
		Turn(rupperleg, x_axis, rad(-20), LEG_SPEED * 4)
		Turn(rlowerleg, x_axis, rad(25), LEG_SPEED * 4)
		Turn(rtoe, x_axis, rad(-5), LEG_SPEED * 4)
		Turn(lupperleg, x_axis, rad(-20), LEG_SPEED * 4)
		Turn(llowerleg, x_axis, rad(25), LEG_SPEED * 4)
		Turn(ltoe, x_axis, rad(-5), LEG_SPEED * 4)
		--Move(pelvis, y_axis, -7.6, LEG_SPEED * 18)
		Move(pelvis, z_axis, -4.3, LEG_SPEED * 18)
		PlaySound("stomp", 25)
		Sleep (100)
		--Recover
		Move(pelvis, y_axis, 0, LEG_SPEED * 8)
		Move(pelvis, z_axis, 0, LEG_SPEED * 8)
		anim_Reset()
--		Spring.Echo("anim_StopJump Completed")
end

-- Walk script
function anim_Walk()
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
	while true do
		--Spring.Echo("Step ONE")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(25), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(25), LEG_SPEED)
		Turn(ltoe, x_axis, rad(-15), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-25), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(15), LEG_SPEED)
		Turn(rtoe, x_axis, rad(45), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(ltoe, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		Sleep(10)
		--Spring.Echo("Step TWO")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(25), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(45), LEG_SPEED)
		Turn(ltoe, x_axis, rad(-60), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-45), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(0), LEG_SPEED)
		Turn(rtoe, x_axis, rad(40), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(ltoe, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		Sleep(10)
		--Spring.Echo("Step THREE")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(60), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(15), LEG_SPEED)
		Turn(ltoe, x_axis, rad(0), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-30), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(15), LEG_SPEED)
		Turn(rtoe, x_axis, rad(15), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(ltoe, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		Sleep(10)
		--Spring.Echo("Step FOUR")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-10), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-15), LEG_SPEED)
		Turn(ltoe, x_axis, rad(30), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(0), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(5), LEG_SPEED)
		Turn(rtoe, x_axis, rad(0), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(ltoe, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		Sleep(10)
		--Spring.Echo("Step FIVE")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-25), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-15), LEG_SPEED)
		Turn(ltoe, x_axis, rad(45), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(25), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(25), LEG_SPEED)
		Turn(rtoe, x_axis, rad(-45), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(ltoe, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		Sleep(10)
		--Spring.Echo("Step SIX")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-45), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(0), LEG_SPEED)
		Turn(ltoe, x_axis, rad(60), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(25), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(45), LEG_SPEED)
		Turn(rtoe, x_axis, rad(-60), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(ltoe, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		Sleep(10)
		--Spring.Echo("Step SEVEN")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-30), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(15), LEG_SPEED)
		Turn(ltoe, x_axis, rad(15), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(45), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(15), LEG_SPEED)
		Turn(rtoe, x_axis, rad(0), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(ltoe, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		Sleep(10)
		--Spring.Echo("Step EIGHT")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(0), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(5), LEG_SPEED)
		Turn(ltoe, x_axis, rad(0), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-10), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(-15), LEG_SPEED)
		Turn(rtoe, x_axis, rad(30), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(ltoe, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rtoe, x_axis)
		Sleep(10)
	end
end

function anim_Reset()
	Signal(SIG_ANIMATE)
--	Spring.Echo("anim_Reset")
	Turn(pelvis, z_axis, rad(0), LEG_SPEED)
	Turn(lupperleg, x_axis, rad(0), LEG_SPEED)
	Turn(llowerleg, x_axis, rad(0), LEG_SPEED)
	Turn(ltoe, x_axis, rad(0), LEG_SPEED)
	Turn(rupperleg, x_axis, rad(0), LEG_SPEED)
	Turn(rlowerleg, x_axis, rad(0), LEG_SPEED)
	Turn(rtoe, x_axis, rad(0), LEG_SPEED)
	--Move(lupperarm, y_axis, 0, LEG_SPEED)
	--Move(rupperarm, y_axis, 0, LEG_SPEED)
	PlaySound("stomp")
	Sleep(100)
end