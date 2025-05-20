--[[
Init script

Runs once when the game is loaded, which is when the main menu is reached for
the first time. Game functions are unavailable.
]]

-- -------------------------------------------------------------------------- --
-- Header                                                                     --
-- -------------------------------------------------------------------------- --

RequireSystemAccess()
RequireLoaderVersion(10)

-- -------------------------------------------------------------------------- --
-- Load Package / Library                                                     --
-- -------------------------------------------------------------------------- --

local lib, err = loadlib(GetPackageFilePath('MainMenu.dll'), 'MainMenu')
if type(lib) ~= 'function' then error(err) end
lib()

-- -------------------------------------------------------------------------- --
-- Load Scripts                                                               --
-- -------------------------------------------------------------------------- --

LoadScript('core/init.lua')
LoadScript('core/setup.lua')
LoadScript('API.lua')

-- -------------------------------------------------------------------------- --
-- Import                                                                     --
-- -------------------------------------------------------------------------- --

local ais = AUTO_INPUT_SWITCH

-- -------------------------------------------------------------------------- --
-- Create Thread                                                              --
-- -------------------------------------------------------------------------- --
-- Runs once when in the main menu for the first time (game launch)

ais.Thread.Init = CreateSystemThread(function()
  local autoInputSwitch = ais.GetSingleton()
  while true do
    Wait(0)
    autoInputSwitch:MainLogic()
  end
end)
