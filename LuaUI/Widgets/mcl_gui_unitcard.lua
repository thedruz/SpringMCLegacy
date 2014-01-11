function widget:GetInfo()
	return {
		name      = "Unit Card",
		desc      = "Displays unit information.",
		author    = "Smoth",
		date      = "Jan, 2014",
		license   = "PD",
		layer     = 5,
		enabled   = false  -- loaded by default?
	}
end

--spring stuffs
local spGetSelectedUnits	= Spring.GetSelectedUnits 
local spGetUnitDefID		= Spring.GetUnitDefID
local spGetUnitRulesParam	= Spring.GetUnitRulesParam
local spGetUnitHealth		= Spring.GetUnitHealth

local green	= { 0.0, 1.0, 0.0, 1.0}
local darkGreen	= { 0.0, 0.7, 0.0, 1.0}
local white	= { 1.0, 1.0, 1.0, 1.0}
local grey	= { 0.4, 0.4, 0.4, 1.0}
local red	= { 1.0, 0.0, 0.0, 1.0}
local black = { 0.0, 0.0, 0.0, 1.0}
local clear = { 0.0, 0.0, 0.0, 0.0}
local olive = { 0.25, 0.3, 0.1, 1.0}

local ammoTypes = {	ac2		= "ammo_ac2", 
					ac5		= "ammo_ac5", 
					ac10	= "ammo_ac10", 
					ac20	= "ammo_ac20", 
					lrm		= "ammo_lrm", 
					srm		= "ammo_srm",  
					mrm		= "ammo_mrm",  
					atm		= "ammo_atm",  
					gauss	= "ammo_gauss",  
					narc	= "ammo_narc", 
					arrow	= "ammo_arrow", }

local jumpJetsColor	= { 0.3, 0.5, 1.0, 1.0}
local HPColor		= { 0.0, 0.5, 1.0, 1.0}
local XPColor		= white
-- done so we are not frequently building a new table for colors
local chestColorTable		= green
local colortable			= green
local heatColorTable		= clear

-- TODO: until we get scaling of font size within elements this will have to do
local vsx,vsy = gl.GetViewSizes()

local fontSizes	={	large	= vsx/87.27272727272727,
					medium	= vsx/160,
					small	= vsx/240,}
--chili stuffs
local Chili 

-- windows
local mechCardWindow
-- child windows
local mechWindow
local mechWeaponsWindow
local mechStatsWindow
local mechAmmoWindow
local mechCardName
local mechHeat
local mechOverHeat
local testbutton

-- current mech
local currentUnitDefId
local currentUnitId
local lastUnitId

-- list for mech parts. Used to determine what parts are 
-- displayed in card and what the image is named
local partsList	= {	mech	= {	"chest", "arm_left", "arm_right", "leg_left", "leg_right"},
					tank	= {	"turret", "base"},
					aero	= {	"body", "left_wing", "right_wing"},
					vtol	= {	"body", "rotor"},}
					

local currentPartsList	= {}

local partsParamList	= {	arm_left	= "limb_hp_left_arm",
							arm_right	= "limb_hp_right_arm",
							turret		= "limb_hp_turret",
							rotor		= "limb_hp_rotor",
							left_wing	= "limb_hp_lwing",
							right_wing	= "limb_hp_rwing",}
						
-- weapon lists for side bar
local mechWeapons		= {}
local CMD_WEAPON_TOGGLE = Spring.GetGameRulesParam("CMD_WEAPON_TOGGLE")

-- parts for display
local parts			= { mech 	= {},
						tank	= {},
						vtol 	= {},
						aero	= {},}
						
-- temporary storage for part list
local currentParts	= {}

-- ammo details for display
local ammoTotals		= {}
-- stores all known ammo types for this mech
local ammoNameCache		= {}

local dangerZONE	= false
local phase			= 0

-------------------------------------------------------------------------------------
-- Function to read string into table
-------------------------------------------------------------------------------------
local function StringToTable(input)
   return loadstring("return " .. (input or "{}"))()
end

-------------------------------------------------------------------------------------
-- Sets damage values on parts display
-------------------------------------------------------------------------------------
local function MechPartStatus(chestColorTable)
	-- get part damage
	for partId, partName in pairs(currentPartsList)do
		-- check to ensure this part has been paired with a param
		if partsParamList[partName] then
			local partHealth 	= spGetUnitRulesParam(currentUnitId, partsParamList[partName]) or 100
			colortable	= {((100 - partHealth)/100), (partHealth/100), 0 ,1}
			--Spring.Echo(partName,partHealth)
			
			-- part destroyed
			if partHealth <1 then
				colortable = black
			end
			currentParts[partId].color =	colortable
			currentParts[partId]:Invalidate()
		else
			currentParts[partId].color =	chestColorTable
			currentParts[partId]:Invalidate()		
		end
	end
end

-------------------------------------------------------------------------------------
-- constrols strobing effect used by the heat warning
-------------------------------------------------------------------------------------
local function HeatPulse()
	phase = phase + 0.2
	if dangerZONE then -- LANA! LAAAAAAAAAANA!
		local pulseValue = .5+.5*math.sin(phase)
		local inversePulseValue = .5*math.sin(phase/2)
		--Spring.Echo(inversePulseValue)
		mechOverHeat.color		= {pulseValue, 0,  0, 1};
		mechOverHeat:Invalidate()
		mechOverHeat.children[1].font.color	= {(inversePulseValue)+0.5,(0.5*inversePulseValue)+0.5,0,1};
		mechOverHeat.children[1]:SetCaption("DANGER")
		mechOverHeat.children[1]:Invalidate()
		dangerZONE = true
	else
		dangerZONE = false
		mechOverHeat.color	= {0,0,0,0};
		mechOverHeat:Invalidate()
		mechOverHeat.children[1]:SetCaption("")
	end
end

local function ToggleWeapon(unitID, unitDefID, weaponNum, button)
	local oldStatus = spGetUnitRulesParam(unitID, "weapon_" .. weaponNum) or "active" -- nil at first
	Spring.GiveOrderToUnit(unitID, CMD_WEAPON_TOGGLE, {weaponNum}, {})
	if oldStatus == "active" then -- was just disabled
		button.backgroundColor	= black
		button:Invalidate()	
		button:SetCaption("--Disabled--")			
	elseif oldStatus == "disabled" then -- was just enabled
		button.backgroundColor	= darkGreen
		button:Invalidate()	
		button:SetCaption(WeaponDefs[unitDefID.weapons[weaponNum].weaponDef].description)
	else -- weapon is destroyed
	end
		
end

-------------------------------------------------------------------------------------
-- Initializes unit stats at start
-------------------------------------------------------------------------------------
local function FillCardStats()
	if currentUnitId then
		local health, maxHealth	= spGetUnitHealth(currentUnitId)
		local currentDef		= UnitDefs[currentUnitDefId]
		local weapons			= currentDef.weapons
		colortable				= green
		
		-- Spring.Echo(currentUnitDefId, UnitDefs[currentUnitDefId].humanName)
		mechCardName:SetCaption(UnitDefs[currentUnitDefId].humanName)
		
		--clear all weapons
		for counter = 0, 11 do
			mechWeaponsWindow:RemoveChild(mechWeapons[counter])
		end
		
		--get weapon status
		local lastWeaponId
		for weaponNum, weaponUnitDef in pairs(weapons) do
			--Spring.Echo( WeaponDefs[weaponUnitDef.weaponDef].description)
			local weaponStatus	= spGetUnitRulesParam(currentUnitId, "weapon_" .. weaponNum)		
			local currentWeapon		= mechWeapons[weaponNum-1]
			if weaponStatus == "disabled" then
				weaponStatus	= "--Disabled--"
				currentWeapon.backgroundColor	= black
				currentWeapon:Invalidate()	
			else
				weaponStatus	= WeaponDefs[weaponUnitDef.weaponDef].description
				currentWeapon.backgroundColor	= darkGreen
				currentWeapon:Invalidate()	
			end
			
			currentWeapon:SetCaption(weaponStatus)
			currentWeapon.OnClick = { function(self)
					ToggleWeapon(currentUnitId, currentDef, weaponNum, self)
				end }
			mechWeaponsWindow:AddChild(mechWeapons[weaponNum-1])
			
			lastWeaponId = weaponNum
		end

		
		-- set hp bar and chest damage
		-- Spring.Echo(health/maxHealth,health,maxHealth)
		chestColorTable	= {((maxHealth - health)/maxHealth), (health/maxHealth), 0 ,1}
			
		MechPartStatus(chestColorTable)
		mechStatsWindow.children[2]:SetValue(spGetUnitRulesParam(currentUnitId, "jump_reload_bar") or 0)
		mechStatsWindow.children[3]:SetValue(spGetUnitRulesParam(currentUnitId, "perk_xp")  or 0)

		-- hiding extra ammo windows
		for counter = 1, 4 do		
			mechAmmoWindow:RemoveChild(ammoTotals[counter])
		end
		
		-- show only what we have, if we have ammo
		if ammoNameCache[currentUnitDefId] then
			for k,v in pairs(ammoNameCache[currentUnitDefId])do
				--Spring.Echo(k, ammoTypes[v])
				mechAmmoWindow:AddChild(ammoTotals[k])
				mechAmmoWindow.children[k]:SetCaption(v)
				mechAmmoWindow.children[k]:SetValue(spGetUnitRulesParam(currentUnitId, ammoTypes[v])  or "0")
			end
		end
		--Spring.Echo(spGetUnitRulesParam(currentUnitId, "heat") or 0)
		if (spGetUnitRulesParam(currentUnitId, "excess_heat") or 0) > 50 then
			dangerZONE = true
		else
			dangerZONE = false
		end
		HeatPulse()
		
					
		local heat = spGetUnitRulesParam(currentUnitId, "heat") or 0
		if heat >10 then
			heatColorTable	= { heat/100, 0, 0, 1}
			--Spring.Echo(heatColorTable[1], heatColorTable[2], heatColorTable[3], heatColorTable[4])
		else				
			heatColorTable	= clear
		end
			
		--Spring.Echo(heat)
		mechStatsWindow.children[1].color	= heatColorTable
		mechStatsWindow.children[1]:SetValue(heat)
		mechHeat.color		= heatColorTable;
		mechHeat:Invalidate()
	end
end

-------------------------------------------------------------------------------------
-- creates initial ui elements
-------------------------------------------------------------------------------------
local function CreateWindows()	
	mechCardWindow = Chili.Window:New{
		--parent	= Chili.Screen0;
		name	= "mech card";
		right	= "0%";
		y		= "25%";
		width	= "15%";
		height	= "35%";
		draggable	= false;
		resizable	= false;
		color		= grey;
		padding		= {8,8,8,8};
	}
	
	mechCardName = Chili.Label:New{
		parent	= mechCardWindow;
		caption	= "No Mech Selected";
		valign	= "top";
		x		= "5%";
		fontsize	= fontSizes.large;
		minWidth	= 0;
		minHeight	= 0;
	}	
	
	mechWindow = Chili.Window:New{
		parent	= mechCardWindow;
		x		= "0%";
		y		= "10%";
		width	= "50%";
		height	= "50%";
		color		= grey;
		draggable	= false;
		resizable	= false;
		padding		= {0,0,0,0};
	}
	
	mechHeat = Chili.Window:New{
		parent	= mechWindow;
		TileImage	= ":cl:bitmaps/ui/infocard/screen.png";
		width		= "100%";
		height		= "100%";
		color		= heatColorTable;
		draggable	= false;
		resizable	= false;
	}	
		
	mechOverHeat = Chili.Image:New{
		file		= ":cl:bitmaps/ui/infocard/warning_bar.png";
		parent		= mechHeat;
		y			= "30%";
		width		= "100%";
		height		= "30%";
		color		= clear;
		draggable	= false;
		resizable	= false;
		keepAspect	= false;
		children	= {
			Chili.Label:New{
				caption		= "";	
				y			= "10%";
				fontsize	= fontSizes.large;
				minWidth	= 0;
				minHeight	= 0;
			}			
		};
	}
	
	mechWeaponsWindow = Chili.Window:New{
		parent	= mechCardWindow;
		name	= "mech weapons list";
		right	= "0%";
		y		= "10%";
		width	= "49%";
		height	= "90%";		
		color		= grey;
		draggable	= false;
		resizable	= false;
		padding		= {8,8,8,8};
	}
	
	mechStatsWindow = Chili.Window:New{
		parent	= mechCardWindow;
		x		= "0%";
		y		= "60%";
		width	= "49%";
		height	= "19%";
		color		= grey;
		draggable	= false;
		resizable	= false;
		padding		= {8,8,8,8};
		children = {
			Chili.Progressbar:New{
				name			= "Mech health";
				color			= HPColor;
				backgroundColor	= black;
				y				= "00%";
				x				= "15%";
				height			= "30%";
				width			= "85%";
			},
			Chili.Progressbar:New{
				name			= "Mech Jumpjet Fuel";
				color			= jumpJetsColor;
				backgroundColor	= black;
				y				= "35%";
				x				= "15%";
				height			= "30%";
				width			= "85%";
			},
			Chili.Progressbar:New{			
				name			= "Mech Perk XP";
				color			= XPColor;
				backgroundColor	= black;
				y				= "70%";
				x				= "15%";
				height			= "30%";
				width			= "85%";
			},
			Chili.Label:New{
				caption	= "H";
				y		= "0%";
				x		= "0%";
				fontsize = fontSizes.medium;
			},		
			Chili.Label:New{
				caption	= "J";
				y		= "35%";
				x		= "0%";
				fontsize = fontSizes.medium;
			},		
			Chili.Label:New{
				caption	= "XP";
				y		= "60%";
				x		= "0%";
				fontsize = fontSizes.medium;
			},		
		}
	}
		
	mechAmmoWindow = Chili.Window:New{
		parent	= mechCardWindow;
		x		= "0%";
		y		= "80%";
		width	= "49%";
		height	= "19%";
		color		= grey;
		draggable	= false;
		resizable	= false;
		padding		= {8,8,8,8};
	}
	
end

-------------------------------------------------------------------------------------
-- builds out extra elements so the code is not bloated
-------------------------------------------------------------------------------------
local function FillOutWindows()
	-- builds out weapon list
	for counter = 0 ,11 do
		local currentLevel = (counter)*10
		mechWeapons[counter] = 	Chili.Button:New{
				parent 				= mechWeaponsWindow;				
				name				= "mech weapon #" .. counter;
				caption				= '-- OFFLINE --';
				fontsize			= fontSizes.medium;
				x					= "0%";
				y					= currentLevel .. "%";
				width				= "100%";  
				height				= "12%";
				backgroundColor 	= grey;
				OnClick = { function(self)
					ToggleWeapon(counter)
					--Spring.SendLuaRulesMsg ( cmd )
				end }, -- ToggleWeapon(counter)
			}
	end
	
	--builds out unit images
	for partType,_	in pairs(partsList)do
		-- for each type, as in mech, unit etc
		for partNumber, partName in pairs(partsList[partType])do
			parts[partType][partNumber] = Chili.Image:New{
				parent		= mechWindow;
				file 		= ":cl:bitmaps/ui/infocard/"..partType.."/dummy_"..partName..".png";
				x			= "5%";
				y			= "5%";
				height		= "90%";
				width		= "90%";
				keepAspect	= false;
				color		= black;}
		end
	end
	
	-- ammo counters
	for counter = 1, 4 do
		local yPosition = (counter - 1) *25
		ammoTotals[counter] = Chili.Progressbar:New{
				caption			= "Ammo";
				fontSize		= fontSizes.medium;
				color			= grey;
				font			= {	outline			= true;
									outlineWidth	= 5;};
				backgroundColor	= black;
				y				= yPosition .. "%";
				height			= "25%";
				width			= "100%";
			}
	end
end 

-------------------------------------------------------------------------------------
-- Init
-------------------------------------------------------------------------------------
function widget:Initialize()
	Chili = WG.Chili
	
	if (not Chili) then
		widgetHandler:RemoveWidget()
		return
	end
	
	local tempAmmoTable	= {}
	for unitDefId, unitDef in pairs(UnitDefs)do
		if unitDef.customParams and unitDef.customParams.maxammo then
			tempAmmoTable[unitDefId] =	StringToTable(unitDef.customParams.maxammo)
			--Spring.Echo(unitDefId,tempAmmoTable[unitDefId])
		end
	end	
	
	for unitDefId,_ in pairs(UnitDefs)do
		local counter = 1
		--not all units may have ammo ratings
		if tempAmmoTable[unitDefId] then
			ammoNameCache[unitDefId] = {}		
			for k,v in pairs(tempAmmoTable[unitDefId])do
				ammoNameCache[unitDefId][counter] = k			
				counter = counter+1
			end
		end
	end
	
	CreateWindows()
	FillOutWindows()
end	

-------------------------------------------------------------------------------------
-- update
-------------------------------------------------------------------------------------
function widget:Update(s) 
	local health, maxHealth	

	--if we have anything selected
	local currentUnits = spGetSelectedUnits()	
	--if we have only 1 unit selected
	if #currentUnits == 1 then
		WG.currentUnitId = currentUnits[1]
	end
	
	--only once, only on unit change
	if WG.currentUnitId ~= lastUnitId then
		Chili.Screen0:RemoveChild(mechCardWindow)
		
		lastUnitId			= WG.currentUnitId
		currentUnitId		= WG.currentUnitId
		currentUnitDefId	= spGetUnitDefID(currentUnitId)
		local unitType		= UnitDefs[currentUnitDefId].customParams.unittype
		local unitDef		= UnitDefs[currentUnitDefId]
		
		Chili.Screen0:AddChild(mechCardWindow)
		
		--checking unit type if the thing is a vehicle
		if unitType == "vehicle" then
			if	unitDef.hoverAttack then
				unitType = "vtol"
			elseif unitDef.canFly and not unitDef.hoverAttack then
				unitType = "aero"
			else
				unitType = "tank"
			end
		end

		if unitType then
			
			-- TODO: FIND A MORE ELEGANT SOLUTON!
			-- rips out all possible unit images
			for partType,_	in pairs(partsList)do
				-- for each type, as in mech, unit etc
				for partNumber, partName in pairs(partsList[partType])do
					mechWindow:RemoveChild(parts[partType][partNumber])
				end
			end	
				
			-- changes image set based on type.
			if partsList[unitType]then
				currentParts			= parts[unitType]
				currentPartsList		= partsList[unitType]
				-- builds out mech image
				for partNumber, partName in pairs(currentPartsList)do
					mechWindow:AddChild(currentParts[partNumber])
				end
			else
				Spring.Echo("it appears we have encountered an uncovered unitType", unitType)
			end
			
			FillCardStats()		
		--else
			--Spring.Echo(UnitDefs[currentUnitDefId].customParams.unittype)
		end
	-- not a new unit lets update it's stats.
	else		
		if currentUnitId then		
			health, maxHealth	= spGetUnitHealth(currentUnitId)
			if maxHealth and health > 0 then
				chestColorTable	= {((maxHealth - health)/maxHealth), (health/maxHealth), 0 ,1}
					
				MechPartStatus(chestColorTable)
				mechStatsWindow.children[2]:SetValue(spGetUnitRulesParam(currentUnitId, "jump_reload_bar") or 0)
				mechStatsWindow.children[3]:SetValue(spGetUnitRulesParam(currentUnitId, "perk_xp") or 0)

				-- update ammo display when units have ammo
				if ammoNameCache[currentUnitDefId] then
					for k,v in pairs(ammoNameCache[currentUnitDefId])do
						mechAmmoWindow.children[k]:SetValue(spGetUnitRulesParam(currentUnitId, ammoTypes[v])  or "0")
					end
				end

				
				local heat = spGetUnitRulesParam(currentUnitId, "heat") or 0				

				if heat >10 then
					heatColorTable	= { heat/100, (heat-75)/100, 0, 1}
					--Spring.Echo(heatColorTable[1], heatColorTable[2], heatColorTable[3], heatColorTable[4])
				else				
					heatColorTable	= clear
				end
				
				if (spGetUnitRulesParam(currentUnitId, "excess_heat") or 0) > 50 then
					dangerZONE = true
					heatColorTable	= red
					HeatPulse()
				else
					dangerZONE = false
				end	
				
				--Spring.Echo(heat)
				mechStatsWindow.children[1].color	= heatColorTable
				mechStatsWindow.children[1]:SetValue(heat)
				mechHeat.color			= heatColorTable;
				mechHeat:Invalidate()
			else			
				Chili.Screen0:RemoveChild(mechCardWindow)
			end
		end
	end
end