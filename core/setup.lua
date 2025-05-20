-- -------------------------------------------------------------------------- --
-- Import                                                                     --
-- -------------------------------------------------------------------------- --

local ais = AUTO_INPUT_SWITCH -- Shorten
local AutoInputSwitch = ais.Class.AutoInputSwitch --[[@as AutoInputSwitch]]

-- -------------------------------------------------------------------------- --
-- Get the Pointer                                                            --
-- -------------------------------------------------------------------------- --

-- Memory address is found by using Cheat Engine

-- The memory address of the 'Enable XBOX 360 Movement' in the 'CONTROLS' menu
-- 0: enabled, 1: disabled
ais.XBOX_MOVE_PTR = ptr('0x00BC7490') --[[@as userdata]]

-- The current address of the input controller - 0: kbm, 1: gamepad
ais.CTRL_PTR = ptr('0x020CECE8') --[[@as userdata]]

-- -------------------------------------------------------------------------- --
-- Define a Method to Get the Instance                                        --
-- -------------------------------------------------------------------------- --

---@return AutoInputSwitch
function AUTO_INPUT_SWITCH.GetSingleton()
  if not ais.autoInputSwitch then
    ais.autoInputSwitch = AutoInputSwitch.new(ais.XBOX_MOVE_PTR, ais.CTRL_PTR)
  end
  return ais.autoInputSwitch
end

-- Create immediately for the first time, discard the return value
ais.GetSingleton()
