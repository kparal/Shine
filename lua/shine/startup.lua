--[[
	Shine entry system startup file.
]]

if Predict then return end

local Trace = debug.traceback()

if Trace:find( "Main.lua" ) or Trace:find( "Loading.lua" ) then return end

-- I have no idea why it's called this.
Shine = {}

local include = Script.Load

function Shine.LoadScripts( Scripts, OnLoadedFuncs )
	for i = 1, #Scripts do
		include( "lua/shine/"..Scripts[ i ] )

		if Shine.Error then
			if Shine.Hook then
				Shine.Hook.Disabled = true
			end

			break
		end

		if OnLoadedFuncs[ Scripts[ i ] ] then
			OnLoadedFuncs[ Scripts[ i ] ]()
		end
	end
end

local InitScript

if Server then
	InitScript = "lua/shine/init.lua"
elseif Client then
	InitScript = "lua/shine/cl_init.lua"
end

-- This function is totally not inspired by Shine's hook system :P
ModLoader.SetupFileHook( "lua/ConfigFileUtility.lua", InitScript, "pre" )
