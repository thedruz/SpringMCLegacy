function widget:GetInfo()
  return {
    name      = "MC:L - Beacon Ranges",
    desc      = "Shows a beacons's capping radius and team colour",
    author    = "CarRepairer and Evil4Zerggin",
    date      = "28 August 2009",
    license   = "GNU GPL v2",
    layer     = 5,
    enabled   = true  --  loaded by default?
  }
end

-- function localisations
-- Synced Read
local GetGroundHeight     = Spring.GetGroundHeight
local GetTeamUnitsByDefs   = Spring.GetTeamUnitsByDefs
local GetUnitPosition = Spring.GetUnitPosition
local GetUnitTeam         = Spring.GetUnitTeam
local GetUnitViewPosition = Spring.GetUnitViewPosition
local GetUnitRulesParam    = Spring.GetUnitRulesParam
local GetTeamColor = Spring.GetTeamColor --cacheing not appreciably faster, if at all
-- Unsynced Read
local IsUnitVisible       = Spring.IsUnitVisible

-- OpenGL
local glCallList =  gl.CallList
local glSmoothing = gl.Smoothing
local glShape = gl.Shape
local glPushMatrix = gl.PushMatrix
local glPopMatrix = gl.PopMatrix
local glTranslate = gl.Translate
local glScale = gl.Scale
local GL_QUAD_STRIP = GL.QUAD_STRIP

local PI = math.pi
local sin, cos = math.sin, math.cos

-- constants
local FLAG_DEF_ID = {
	UnitDefNames["beacon"].id,
	--[[UnitDefNames["outpost_vehicledepot"].id,
	UnitDefNames["outpost_c3center"].id, 
	UnitDefNames["outpost_garrison"].id, 
	UnitDefNames["outpost_listeningpost"].id, 
	UnitDefNames["outpost_controltower"].id, ]]
}

local FLAG_RADIUS          = 460 -- current flagkiller weapon radius, we may want to open this up to modoptions TODO: read from a single customparam
local FLAG_CAP_THRESHOLD  = 20 -- number of capping points needed for a flag to switch teams, again possibilities for modoptions -- TODO: ditto

local maxAlpha = 0.5
local innerSize = 0.875
local circleDivs = 6--4
local circleInc = 2 * PI / circleDivs

-- variables
local flags = {}
local teams = Spring.GetTeamList()

local alphavals = {}

local circleLists = {}

local function DrawTeamCircle(teamID)
  local vertices = {}
  local r, g, b = GetTeamColor(teamID)
  
  for i = 0, circleDivs do
    local angle = i * circleInc
    local ox = cos(angle)
    local oz = sin(angle)
    local ix = ox * innerSize
    local iz = oz * innerSize
    vertices[2*i+1] = { v = {ix, 0, iz}, c = {r, g, b, 0} }
    vertices[2*i+2] = { v = {ox, 0, oz}, c = {r, g, b, maxAlpha} }
  end
  
  glShape(GL_QUAD_STRIP, vertices)
end

function widget:Initialize()
  local glCreateList = gl.CreateList
  for i = 1, #teams do
    local teamID = teams[i]
    circleLists[teamID] = glCreateList(DrawTeamCircle, teamID, FLAG_RADIUS)
  end
end

function widget:Shutdown()
  local glDeleteList = gl.DeleteList
  for i = 1, #teams do
    local teamID = teams[i]
    glDeleteList(circleLists[teamID])
  end
end

function widget:DrawWorldPreUnit()
  --glSmoothing(true, true, true)

  for i = 1, #teams do
    local teamID = teams[i]
    local teamFlags = GetTeamUnitsByDefs(teamID, FLAG_DEF_ID)
    if teamFlags then
      for j = 1, #teamFlags do
        unitID = teamFlags[j]
        if IsUnitVisible(unitID, FLAG_RADIUS, true) then
          local x, y, z = GetUnitPosition(unitID)
		  if y <= GetGroundHeight(x, z) + 5 then
			glPushMatrix()
				glTranslate(x, y, z)
				glScale(FLAG_RADIUS, 1, FLAG_RADIUS)
				glCallList(circleLists[teamID])
          
				for j = 1, #teams do
				local capTeamID = teams[j]
				local teamCapValue = GetUnitRulesParam(unitID, "cap" .. tostring(capTeamID))
				if (teamCapValue or 0) > 0 then
					local scale = teamCapValue / FLAG_CAP_THRESHOLD
					glPushMatrix()
						glScale(scale, 1, scale)
						glCallList(circleLists[capTeamID])
					glPopMatrix()
				end
			end
          glPopMatrix()
		  end
        end
      end
    end
  end
  
  --glSmoothing(false, false, false)
end
