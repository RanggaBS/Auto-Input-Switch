--[[

Bully SE - Auto Input Switch
Author: RBS ID

]]

-- -------------------------------------------------------------------------- --
-- Header                                                                     --
-- -------------------------------------------------------------------------- --

RequireLoaderVersion(10)

-- -------------------------------------------------------------------------- --
-- Entry Point                                                                --
-- -------------------------------------------------------------------------- --

function main()
  while not SystemIsReady() do
    Wait(0)
  end

  -- The memory address of the 'Enable XBOX 360 Movement' in the 'CONTROLS' menu
  local userdata = ptr('0x020CECE8') --[[@as table]]

  while true do
    Wait(0)

    -- Check mouse keyboard input first
    if
      IsMouseMoving()
      or IsAnyMouseButtonJustPressed()
      or IsAnyKeyJustPressed()
    then
      userdata.int32 = 0 -- disable

    -- Check the other input controller
    -- 0: keyboard (controlling the player), 1: the second input controller
    elseif IsAnyButtonPressed(1) then
      userdata.int32 = 1 -- enable
    end
  end
end

-- -------------------------------------------------------------------------- --
-- Helper Functions                                                           --
-- -------------------------------------------------------------------------- --

---@param ctrlId 0|1|2|3
---@return boolean
function IsAnyButtonPressed(ctrlId)
  for _, button in ipairs(buttons) do
    if GetStickValue(button, ctrlId) ~= 0 then return true end
  end
  return false
end

---@return boolean
function IsAnyKeyJustPressed()
  for _, key in ipairs(keys) do
    if IsKeyBeingPressed(key) then return true end
  end
  return false
end

---@return boolean
function IsAnyMouseButtonJustPressed()
  for mouseBtn = 0, 2 do -- 0: left click, 1: right, 2: scroll wheel
    if IsMouseBeingPressed(mouseBtn) then return true end
  end
  return false
end

---@return boolean
function IsMouseMoving()
  local mouseX, mouseY = GetMouseInput()
  return mouseX ~= 0 or mouseY ~= 0
end

-- -------------------------------------------------------------------------- --
-- Input Data                                                                 --
-- -------------------------------------------------------------------------- --

buttons =
  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 24 }

keys = {
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'A',
  'ABNT_C1',
  'ABNT_C2',
  'ADD',
  'APOSTROPHE',
  'APPS',
  'AT',
  'AX',
  'B',
  'BACK',
  'BACKSLASH',
  'BACKSPACE',
  'C',
  'CALCULATOR',
  'CAPITAL',
  'CAPSLOCK',
  'CIRCUMFLEX',
  'COLON',
  'COMMA',
  'CONVERT',
  'D',
  'DECIMAL',
  'DELETE',
  'DIVIDE',
  'DOWN',
  'DOWNARROW',
  'E',
  'END',
  'EQUALS',
  'ESCAPE',
  'F',
  'F1',
  'F10',
  'F11',
  'F12',
  'F13',
  'F14',
  'F15',
  'F2',
  'F3',
  'F4',
  'F5',
  'F6',
  'F7',
  'F8',
  'F9',
  'G',
  'GRAVE',
  'H',
  'HOME',
  'I',
  'INSERT',
  'J',
  'K',
  'KANA',
  'KANJI',
  'L',
  'LALT',
  'LBRACKET',
  'LCONTROL',
  'LEFT',
  'LEFTARROW',
  'LMENU',
  'LSHIFT',
  'LWIN',
  'M',
  'MAIL',
  'MEDIASELECT',
  'MEDIASTOP',
  'MINUS',
  'MULTIPLY',
  'MUTE',
  'MYCOMPUTER',
  'N',
  'NEXT',
  'NEXTTRACK',
  'NOCONVERT',
  'NUMLOCK',
  'NUMPAD0',
  'NUMPAD1',
  'NUMPAD2',
  'NUMPAD3',
  'NUMPAD4',
  'NUMPAD5',
  'NUMPAD6',
  'NUMPAD7',
  'NUMPAD8',
  'NUMPAD9',
  'NUMPADCOMMA',
  'NUMPADENTER',
  'NUMPADEQUALS',
  'NUMPADMINUS',
  'NUMPADPERIOD',
  'NUMPADPLUS',
  'NUMPADSLASH',
  'NUMPADSTAR',
  'O',
  'OEM_102',
  'P',
  'PAUSE',
  'PERIOD',
  'PGDN',
  'PGUP',
  'PLAYPAUSE',
  'POWER',
  'PREVTRACK',
  'PRIOR',
  'Q',
  'R',
  'RALT',
  'RBRACKET',
  'RCONTROL',
  'RETURN',
  'RIGHT',
  'RIGHTARROW',
  'RMENU',
  'RSHIFT',
  'RWIN',
  'S',
  'SCROLL',
  'SEMICOLON',
  'SLASH',
  'SLEEP',
  'SPACE',
  'STOP',
  'SUBTRACT',
  'SYSRQ',
  'T',
  'TAB',
  'U',
  'UNDERLINE',
  'UNLABELED',
  'UP',
  'UPARROW',
  'V',
  'VOLUMEDOWN',
  'VOLUMEUP',
  'W',
  'WAKE',
  'WEBBACK',
  'WEBFAVORITES',
  'WEBFORWARD',
  'WEBHOME',
  'WEBREFRESH',
  'WEBSEARCH',
  'WEBSTOP',
  'X',
  'Y',
  'YEN',
  'Z',
}
