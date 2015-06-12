--piece defines
-- NB. local here means main script can't read them, may want to change that for e.g. Killed (or put Killed in here for per-unit death anims! But then other pieces need to be none-local)
local pelvis, torso, lupperleg, llowerleg, rupperleg, rlowerleg, rfronttoes, lfronttoes, lfoot, rfoot = piece ("pelvis", "torso", "lupperleg", "llowerleg", "rupperleg", "rlowerleg", "rfronttoes", "lfronttoes", "lfoot", "rfoot")

--Turning/Movement Locals
local LEG_SPEED = rad(400) * speedMod
local LEG_TURN_SPEED = rad (200) * speedMod

function anim_Turn(clockwise)
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
	while true do
--		Spring.Echo("anim_Turn")
		--Left Leg Up...
		Turn(pelvis, z_axis, rad(-5), LEG_TURN_SPEED)
		Turn(lupperleg, x_axis, rad(30), LEG_TURN_SPEED)
		Turn(llowerleg, x_axis, rad(-40), LEG_TURN_SPEED)
		Turn(lfronttoes, x_axis, rad(15), LEG_TURN_SPEED)
		--Wait for turns...
		WaitForTurn(pelvis, z_axis)
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		--Left Leg Down...
		Turn(pelvis, z_axis, rad(0), LEG_TURN_SPEED)
		Turn(lupperleg, x_axis, rad(0), LEG_TURN_SPEED)
		Turn(llowerleg, x_axis, rad(0), LEG_TURN_SPEED)
		Turn(lfronttoes, x_axis, rad(0), LEG_TURN_SPEED)
		--Wait for turns...
		WaitForTurn(pelvis, z_axis)
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		PlaySound("stomp")
		--Right Leg Up...
		Turn(pelvis, z_axis, rad(5), LEG_TURN_SPEED)
		Turn(rupperleg, x_axis, rad(30), LEG_TURN_SPEED)
		Turn(rlowerleg, x_axis, rad(-40), LEG_TURN_SPEED)
		Turn(rfronttoes, x_axis, rad(15), LEG_TURN_SPEED)
		--Wait for turns...
		WaitForTurn(pelvis, z_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Right Leg Down...
		Turn(pelvis, z_axis, rad(0), LEG_TURN_SPEED)
		Turn(rupperleg, x_axis, rad(0), LEG_TURN_SPEED)
		Turn(rlowerleg, x_axis, rad(0), LEG_TURN_SPEED)
		Turn(rfronttoes, x_axis, rad(0), LEG_TURN_SPEED)
		--Wait for turns
		WaitForTurn(pelvis, z_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		PlaySound("stomp")
	end
end
		
function anim_PreJump()
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
--	Spring.Echo("anim_PreJump")
	anim_Reset()
		--Crouch...
		Turn(rupperleg, x_axis, rad(30), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(-30), LEG_SPEED)
		Turn(lupperleg, x_axis, rad(30), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-30), LEG_SPEED)
		Move(pelvis, y_axis, -5.6, LEG_SPEED * 8)
		Move(pelvis, z_axis, -3.3, LEG_SPEED * 8)
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
		Turn(rfronttoes, x_axis, rad(15), LEG_SPEED * 4)
		Turn(lupperleg, x_axis, rad(5), LEG_SPEED * 4)
		Turn(llowerleg, x_axis, rad(20), LEG_SPEED * 4)
		Turn(lfronttoes, x_axis, rad(15), LEG_SPEED * 4)
		Move(pelvis, y_axis, 0, LEG_SPEED * 4)
		Move(pelvis, z_axis, 0, LEG_SPEED * 4)
		--Wait for turns...
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfronttoes, x_axis)
--	Spring.Echo("anim_StartJump Completed")
end

function anim_HalfJump()
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
--	Spring.Echo("anim_HalfJump")
		--Brace for impact...
		Turn(rupperleg, x_axis, rad(-30), LEG_SPEED / 4)
		Turn(rlowerleg, x_axis, rad(20), LEG_SPEED / 4)
		Turn(rfoot, x_axis, rad(-10), LEG_SPEED / 4)
		Turn(rfronttoes, x_axis, rad(15), LEG_SPEED / 4)
		Turn(lupperleg, x_axis, rad(-30), LEG_SPEED / 4)
		Turn(llowerleg, x_axis, rad(20), LEG_SPEED / 4)
		Turn(lfoot, x_axis, rad(-10), LEG_SPEED / 4)
		Turn(lfronttoes, x_axis, rad(15), LEG_SPEED / 4)
		--WaitForTurns...
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfronttoes, x_axis)
--	Spring.Echo("anim_HalfJump Completed")
end

function anim_StopJump()
	Signal(SIG_ANIMATE)
	SetSignalMask(SIG_ANIMATE)
--	Spring.Echo("anim_StopJump")
		--Touchdown!
		Turn(rupperleg, x_axis, rad(20), LEG_SPEED * 4)
		Turn(rlowerleg, x_axis, rad(-25), LEG_SPEED * 4)
		Turn(rfoot, x_axis, rad(5), LEG_SPEED * 4)
		Turn(rfronttoes, x_axis, rad(0), LEG_SPEED * 4)
		Turn(lupperleg, x_axis, rad(20), LEG_SPEED * 4)
		Turn(llowerleg, x_axis, rad(-25), LEG_SPEED * 4)
		Turn(lfoot, x_axis, rad(5), LEG_SPEED * 4)
		Turn(lfronttoes, x_axis, rad(0), LEG_SPEED * 4)
		Move(pelvis, y_axis, -5.6, LEG_SPEED * 18)
		Move(pelvis, z_axis, -3.3, LEG_SPEED * 18)
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
--		Spring.Echo("anim_Walk")
		--Spring.Echo("Step .5")
		Turn(pelvis, z_axis, rad(5), LEG_SPEED / 10)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(10), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(2.5), LEG_SPEED)
		Turn(lfoot, x_axis, rad(-12.5), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(0), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-10), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(-20), LEG_SPEED)
		Turn(rfoot, x_axis, rad(5), LEG_SPEED)
		Turn(rfronttoes, x_axis, rad(15), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
		
	
		--Spring.Echo("Step 1")
		--Torso--
		Turn(pelvis, z_axis, rad(-5), LEG_SPEED / 10)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(20), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(5), LEG_SPEED)
		Turn(lfoot, x_axis, rad(-25), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(0), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-30), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(0), LEG_SPEED)
		Turn(rfoot, x_axis, rad(10), LEG_SPEED)
		Turn(rfronttoes, x_axis, rad(15), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
			
		--Spring.Echo("Step 1.5")
		--Torso--
		Turn(pelvis, z_axis, rad(-5), LEG_SPEED / 10)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(30), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(7.5), LEG_SPEED)
		Turn(lfoot, x_axis, rad(-25), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(-2.5), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-35), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(0), LEG_SPEED)
		Turn(rfoot, x_axis, rad(10), LEG_SPEED)
		Turn(rfronttoes, x_axis, rad(15), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
		
		--Spring.Echo("Step 2")
		--Torso--
		Turn(pelvis, z_axis, rad(-5), LEG_SPEED / 10)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(40), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(10), LEG_SPEED)
		Turn(lfoot, x_axis, rad(-25), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(-5), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-20), LEG_SPEED * 2)
		Turn(rlowerleg, x_axis, rad(5), LEG_SPEED * 2)
		Turn(rfoot, x_axis, rad(10), LEG_SPEED * 2)
		Turn(rfronttoes, x_axis, rad(15), LEG_SPEED * 2)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
			
		--Spring.Echo("Step 2.5")
		--Torso--
		Turn(pelvis, z_axis, rad(-5), LEG_SPEED / 10)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(45), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-10), LEG_SPEED)
		Turn(lfoot, x_axis, rad(-12.5), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(5), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(-20), LEG_SPEED * 2)
		Turn(rlowerleg, x_axis, rad(12.5), LEG_SPEED * 2)
		Turn(rfoot, x_axis, rad(5), LEG_SPEED * 2)
		Turn(rfronttoes, x_axis, rad(7.5), LEG_SPEED * 2)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		PlaySound("stomp")
		--Sleep(10)
		
		--Spring.Echo("Step 3")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(50), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-30), LEG_SPEED)
		Turn(lfoot, x_axis, rad(0), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(15), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(0), LEG_SPEED * 2)
		Turn(rlowerleg, x_axis, rad(0), LEG_SPEED * 2)
		Turn(rfoot, x_axis, rad(0), LEG_SPEED * 2)
		Turn(rfronttoes, x_axis, rad(0), LEG_SPEED * 2)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
			
		--Spring.Echo("Step 3.5")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(30), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-25), LEG_SPEED)
		Turn(lfoot, x_axis, rad(0), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(15), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(10), LEG_SPEED * 2)
		Turn(rlowerleg, x_axis, rad(2.5), LEG_SPEED * 2)
		Turn(rfoot, x_axis, rad(-25), LEG_SPEED * 2)
		Turn(rfronttoes, x_axis, rad(0), LEG_SPEED * 2)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
		
		--Spring.Echo("Step 4")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(10), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-20), LEG_SPEED)
		Turn(lfoot, x_axis, rad(0), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(15), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(20), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(5), LEG_SPEED)
		Turn(rfoot, x_axis, rad(-25), LEG_SPEED)
		Turn(rfronttoes, x_axis, rad(0), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
		
		--Spring.Echo("Step 4.5")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-10), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(-10), LEG_SPEED)
		Turn(lfoot, x_axis, rad(5), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(15), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(30), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(7.5), LEG_SPEED)
		Turn(rfoot, x_axis, rad(-25), LEG_SPEED)
		Turn(rfronttoes, x_axis, rad(-2.5), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
		
		--Spring.Echo("Step 5")
		--Torso--
		Turn(pelvis, z_axis, rad(5), LEG_SPEED / 10)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-30), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(0), LEG_SPEED)
		Turn(lfoot, x_axis, rad(10), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(15), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(40), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(10), LEG_SPEED)
		Turn(rfoot, x_axis, rad(-25), LEG_SPEED)
		Turn(rfronttoes, x_axis, rad(-5), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
		
		--Spring.Echo("Step 5.5")
		--Torso--
		Turn(pelvis, z_axis, rad(5), LEG_SPEED / 10)
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-35), LEG_SPEED)
		Turn(llowerleg, x_axis, rad(12.5), LEG_SPEED)
		Turn(lfoot, x_axis, rad(10), LEG_SPEED)
		Turn(lfronttoes, x_axis, rad(15), LEG_SPEED)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(45), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(-10), LEG_SPEED)
		Turn(rfoot, x_axis, rad(-12.5), LEG_SPEED)
		Turn(rfronttoes, x_axis, rad(5), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		PlaySound("stomp")
		--Sleep(10)
		
		--Spring.Echo("Step SIX")
		--Left Leg--
		Turn(lupperleg, x_axis, rad(-20), LEG_SPEED * 2)
		Turn(llowerleg, x_axis, rad(5), LEG_SPEED * 2)
		Turn(lfoot, x_axis, rad(10), LEG_SPEED * 2)
		Turn(lfronttoes, x_axis, rad(15), LEG_SPEED * 2)
		--Right Leg--
		Turn(rupperleg, x_axis, rad(50), LEG_SPEED)
		Turn(rlowerleg, x_axis, rad(-30), LEG_SPEED)
		Turn(rfoot, x_axis, rad(0), LEG_SPEED)
		Turn(rfronttoes, x_axis, rad(15), LEG_SPEED)
		--Wait For Turns...--
		WaitForTurn(lupperleg, x_axis)
		WaitForTurn(llowerleg, x_axis)
		WaitForTurn(lfoot, x_axis)
		WaitForTurn(lfronttoes, x_axis)
		WaitForTurn(rupperleg, x_axis)
		WaitForTurn(rlowerleg, x_axis)
		WaitForTurn(rfoot, x_axis)
		WaitForTurn(rfronttoes, x_axis)
		--Sleep(10)
	end
end

function anim_Reset()
	Signal(SIG_ANIMATE)
--	Spring.Echo("anim_Reset")
	Turn(pelvis, z_axis, rad(0), LEG_SPEED)
	Turn(lupperleg, x_axis, rad(0), LEG_SPEED)
	Turn(llowerleg, x_axis, rad(0), LEG_SPEED)
	Turn(lfoot, x_axis, rad(0), LEG_SPEED)
	Turn(lfronttoes, x_axis, rad(0), LEG_SPEED)
	Turn(rupperleg, x_axis, rad(0), LEG_SPEED)
	Turn(rlowerleg, x_axis, rad(0), LEG_SPEED)
	Turn(rfoot, x_axis, rad(0), LEG_SPEED)
	Turn(rfronttoes, x_axis, rad(0), LEG_SPEED)
	PlaySound("stomp")
	Sleep(100)
end