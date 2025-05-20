-- -------------------------------------------------------------------------- --
-- Import                                                                     --
-- -------------------------------------------------------------------------- --

local ais = AUTO_INPUT_SWITCH
local aisApi = ais.API
local Util = ais.Util --[[@as Util]]

-- -------------------------------------------------------------------------- --
-- Methods                                                                    --
-- -------------------------------------------------------------------------- --

-- -------------------------------------------------------------------------- --
-- Get Instances                                                              --
-- -------------------------------------------------------------------------- --

---@return AutoInputSwitch
function aisApi.GetSingleton()
  return ais.GetSingleton()
end

---@return EventManager
function aisApi.GetEventManager()
  return aisApi.GetSingleton():GetEventManager()
end

-- -------------------------------------------------------------------------- --
-- Input Controls                                                             --
-- -------------------------------------------------------------------------- --

---@return 'gamepad'|'keyboard'
function aisApi.GetCurrentController()
  return aisApi.GetSingleton():GetCurrentController()
end

---@return boolean
function aisApi.GetXboxMovementEnabled()
  return aisApi.GetSingleton():GetXboxMovementEnabled()
end

-- -------------------------------------------------------------------------- --
-- Pointers                                                                   --
-- -------------------------------------------------------------------------- --

---@return userdata
function aisApi.GetXboxMovementPointer()
  return aisApi.GetSingleton():GetXboxMovementPointer()
end

---@return userdata
function aisApi.GetControllerPointer()
  return aisApi.GetSingleton():GetControllerPointer()
end

-- -------------------------------------------------------------------------- --
-- Input Detection                                                            --
-- -------------------------------------------------------------------------- --

---@return string?
function aisApi.GetAnyKeyboardKeyPressed()
  local _, key = Util.IsAnyKeyJustPressed()
  return key
end

---@param ctrlId 0|1|2|3
---@return integer?
function aisApi.GetAnyGamepadButtonPressed(ctrlId)
  local _, buttonId = Util.IsAnyGamepadButtonPressed(ctrlId)
  return buttonId
end

-- -------------------------------------------------------------------------- --
-- Events                                                                     --
-- -------------------------------------------------------------------------- --

---@param eventName string
---@param callback function
function aisApi.AddEventListener(eventName, callback)
  aisApi.GetSingleton():GetEventManager():AddListener(eventName, callback)
end

---@param eventName string
---@param callback function
---@return boolean success
function aisApi.RemoveEventListener(eventName, callback)
  return aisApi
    .GetSingleton()
    :GetEventManager()
    :RemoveListener(eventName, callback)
end
