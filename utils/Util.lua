-- -------------------------------------------------------------------------- --
-- Helper Functions / Utilities                                               --
-- -------------------------------------------------------------------------- --

---@class Util
local Util = {}

-- -------------------------------------------------------------------------- --
-- Mouse & Keyboard Input Detection                                           --
-- -------------------------------------------------------------------------- --

---@return boolean
function Util.IsMouseKeyboardActive()
  return Util.IsMouseMoving()
    or Util.IsAnyMouseButtonJustPressed()
    or Util.IsAnyKeyJustPressed()
end

---@return boolean justPressed, string? key
function Util.IsAnyKeyJustPressed()
  for _, key in ipairs(Util.keys) do
    if IsKeyBeingPressed(key) then return true, key end
  end
  return false, nil
end

---@return boolean justPressed, integer? mouseBtn
function Util.IsAnyMouseButtonJustPressed()
  for mouseBtn = 0, 2 do -- 0: left click, 1: right, 2: scroll wheel
    if IsMouseBeingPressed(mouseBtn) then return true, mouseBtn end
  end
  return false, nil
end

---@return boolean isMoving, number mouseX, number mouseY
function Util.IsMouseMoving()
  local mouseX, mouseY = GetMouseInput()
  return mouseX ~= 0 or mouseY ~= 0, mouseX, mouseY
end

-- -------------------------------------------------------------------------- --
-- Controller / Gamepad Input Detection                                       --
-- -------------------------------------------------------------------------- --

---@param ctrlId 0|1|2|3
---@return boolean pressed, integer? buttonId
function Util.IsAnyButtonPressed(ctrlId)
  for _, button in ipairs(Util.buttons) do
    if GetStickValue(button, ctrlId) ~= 0 then return true, button end
  end
  return false, nil
end

---@param ctrlId 0|1|2|3
---@return boolean pressed, integer? buttonId
function Util.IsAnyGamepadButtonPressed(ctrlId)
  for _, btnId in ipairs(Util.buttons) do
    if IsGamepadButtonPressed(btnId, ctrlId) then return true, btnId end
  end
  return false, nil
end

-- -------------------------------------------------------------------------- --
-- Pointer Userdata                                                           --
-- -------------------------------------------------------------------------- --

---@param ptr userdata
---@return integer
function Util.ConvertUdataInt32Value(ptr)
  return Util.IsBullyBytesLoaded() and GetInt32(ptr)
    or tonumber(tostring(ptr.int32)) --[[@as integer]]
end

-- -------------------------------------------------------------------------- --
-- BullyBytes                                                                 --
-- -------------------------------------------------------------------------- --

---@return boolean
function Util.IsBullyBytesLoaded()
  return type(SetInt32) == 'function' and type(GetInt32) == 'function'
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

-- -------------------------------------------------------------------------- --
-- Save to Global Variable                                                    --
-- -------------------------------------------------------------------------- --

AUTO_INPUT_SWITCH.Util = Util
