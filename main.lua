--[[

Bully SE - Auto Input Switch
Author: RBS ID

]]

-- -------------------------------------------------------------------------- --
-- Header                                                                     --
-- -------------------------------------------------------------------------- --

RequireLoaderVersion(10)

local Util = {}

-- -------------------------------------------------------------------------- --
-- Entry Point                                                                --
-- -------------------------------------------------------------------------- --

function main()
  CreateSystemThread(function(...)
    -- Memory address is found by using Cheat Engine

    -- The memory address of the 'Enable XBOX 360 Movement' in the 'CONTROLS' menu
    -- 0: enabled, 1: disabled
    local xboxMovePtr = ptr('0x00BC7490') --[[@as userdata]]

    -- The current address of the input controller - 0: kbm, 1: gamepad
    local ctrlPtr = ptr('0x020CECE8') --[[@as userdata]]

    -- Local variables
    local isMkbActive, isGamepadActive, targetSettingValue

    while true do
      Wait(0)

      isMkbActive = Util.IsMouseMoving()
        or Util.IsAnyMouseButtonJustPressed()
        or Util.IsAnyKeyJustPressed()

      -- Controller ID 1 is typically the first gamepad.
      -- Controller ID 0 is usually keyboard/mouse for player control.
      isGamepadActive = Util.IsAnyButtonPressed(1)

      -- If mouse/keyboard is active, target is 0 (disable Xbox movement).
      -- Else if gamepad is active, target is 1 (enable Xbox movement).
      -- Else, target is nil (no change/update).
      targetSettingValue = isMkbActive and 0 or isGamepadActive and 1 or nil

      if targetSettingValue ~= nil then
        Util.UpdateXboxMovementSetting(xboxMovePtr, ctrlPtr, targetSettingValue)
      end
    end
  end)
end

-- -------------------------------------------------------------------------- --
-- Helper Functions                                                           --
-- -------------------------------------------------------------------------- --

---@param xboxMovePtr userdata
---@param ctrlPtr userdata
---@param targetInt integer
function Util.UpdateXboxMovementSetting(xboxMovePtr, ctrlPtr, targetInt)
  local isBullyBytesLoaded = type(SetInt32) == 'function'
    and type(GetInt32) == 'function'

  local currentValue = isBullyBytesLoaded and GetInt32(ctrlPtr)
    or tonumber(tostring(ctrlPtr.int32)) -- type(xboxMovePtr.int32) == 'userdata'

  if currentValue == targetInt then return end

  local inverse = targetInt == 1 and 0 or 1

  if isBullyBytesLoaded then
    SetInt32(ctrlPtr, targetInt)
    SetInt32(xboxMovePtr, inverse)
    return
  end

  ctrlPtr.int32 = targetInt
  xboxMovePtr.int32 = inverse
end

---@param ctrlId 0|1|2|3
---@return boolean
function Util.IsAnyButtonPressed(ctrlId)
  for _, button in ipairs(Util.buttons) do
    if GetStickValue(button, ctrlId) ~= 0 then return true end
  end
  return false
end

---@return boolean
function Util.IsAnyKeyJustPressed()
  for _, key in ipairs(Util.keys) do
    if IsKeyBeingPressed(key) then return true end
  end
  return false
end

---@return boolean
function Util.IsAnyMouseButtonJustPressed()
  for mouseBtn = 0, 2 do -- 0: left click, 1: right, 2: scroll wheel
    if IsMouseBeingPressed(mouseBtn) then return true end
  end
  return false
end

---@return boolean
function Util.IsMouseMoving()
  local mouseX, mouseY = GetMouseInput()
  return mouseX ~= 0 or mouseY ~= 0
end

-- -------------------------------------------------------------------------- --
-- Input Data                                                                 --
-- -------------------------------------------------------------------------- --

Util.buttons =
  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 24 }

-- stylua: ignore start
Util.keys = {
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'ABNT_C1',
  'ABNT_C2', 'ADD', 'APOSTROPHE', 'APPS', 'AT', 'AX', 'B', 'BACK',
  'BACKSLASH', 'BACKSPACE', 'C', 'CALCULATOR', 'CAPITAL', 'CAPSLOCK',
  'CIRCUMFLEX', 'COLON', 'COMMA', 'CONVERT', 'D', 'DECIMAL', 'DELETE',
  'DIVIDE', 'DOWN', 'DOWNARROW', 'E', 'END', 'EQUALS', 'ESCAPE', 'F',
  'F1', 'F10', 'F11', 'F12', 'F13', 'F14', 'F15', 'F2', 'F3', 'F4',
  'F5', 'F6', 'F7', 'F8', 'F9', 'G', 'GRAVE', 'H', 'HOME', 'I',
  'INSERT', 'J', 'K', 'KANA', 'KANJI', 'L', 'LALT', 'LBRACKET',
  'LCONTROL', 'LEFT', 'LEFTARROW', 'LMENU', 'LSHIFT', 'LWIN', 'M',
  'MAIL', 'MEDIASELECT', 'MEDIASTOP', 'MINUS', 'MULTIPLY', 'MUTE',
  'MYCOMPUTER', 'N', 'NEXT', 'NEXTTRACK', 'NOCONVERT', 'NUMLOCK',
  'NUMPAD0', 'NUMPAD1', 'NUMPAD2', 'NUMPAD3', 'NUMPAD4', 'NUMPAD5',
  'NUMPAD6', 'NUMPAD7', 'NUMPAD8', 'NUMPAD9', 'NUMPADCOMMA',
  'NUMPADENTER', 'NUMPADEQUALS', 'NUMPADMINUS', 'NUMPADPERIOD',
  'NUMPADPLUS', 'NUMPADSLASH', 'NUMPADSTAR', 'O', 'OEM_102', 'P',
  'PAUSE', 'PERIOD', 'PGDN', 'PGUP', 'PLAYPAUSE', 'POWER', 'PREVTRACK',
  'PRIOR', 'Q', 'R', 'RALT', 'RBRACKET', 'RCONTROL', 'RETURN', 'RIGHT',
  'RIGHTARROW', 'RMENU', 'RSHIFT', 'RWIN', 'S', 'SCROLL', 'SEMICOLON',
  'SLASH', 'SLEEP', 'SPACE', 'STOP', 'SUBTRACT', 'SYSRQ', 'T', 'TAB',
  'U', 'UNDERLINE', 'UNLABELED', 'UP', 'UPARROW', 'V', 'VOLUMEDOWN',
  'VOLUMEUP', 'W', 'WAKE', 'WEBBACK', 'WEBFAVORITES', 'WEBFORWARD',
  'WEBHOME', 'WEBREFRESH', 'WEBSEARCH', 'WEBSTOP', 'X', 'Y', 'YEN', 'Z',
}
-- stylua: ignore end
