-- -------------------------------------------------------------------------- --
-- Import                                                                     --
-- -------------------------------------------------------------------------- --

local ais = AUTO_INPUT_SWITCH -- Shorten
local Util = ais.Util --[[@as Util]]
local EventManager = ais.Class.EventManager

-- -------------------------------------------------------------------------- --
-- AutoInputSwitch Class / Main Class                                         --
-- -------------------------------------------------------------------------- --

---@class AutoInputSwitch
---@field private _xboxMovePtr userdata
---@field private _ctrlPtr userdata
---@field private _eventManager EventManager
---@field isEnabled boolean
local AutoInputSwitch = {}
AutoInputSwitch.__index = AutoInputSwitch

-- -------------------------------------------------------------------------- --
-- Constructor                                                                --
-- -------------------------------------------------------------------------- --

---@param xboxMovePtr userdata
---@param ctrlPtr userdata
---@return AutoInputSwitch
function AutoInputSwitch.new(xboxMovePtr, ctrlPtr)
  local instance = setmetatable({}, AutoInputSwitch)

  instance._xboxMovePtr = xboxMovePtr
  instance._ctrlPtr = ctrlPtr
  instance._eventManager = EventManager.new()

  instance.isEnabled = true

  return instance
end

-- -------------------------------------------------------------------------- --
-- Main Methods                                                               --
-- -------------------------------------------------------------------------- --

function AutoInputSwitch:MainLogic()
  if not self.isEnabled then return end

  local targetSettingValue = self:GetInputTargetValue()
  if targetSettingValue == nil then return end
  if self:GetXboxMovementEnabled() == (targetSettingValue == 1) then return end

  self:UpdateXboxMovementSetting(targetSettingValue)
end

---Determine input target value
---@return integer?
function AutoInputSwitch:GetInputTargetValue()
  local isMkbActive = Util.IsMouseKeyboardActive()

  -- Controller ID 1 is typically the first gamepad.
  -- Controller ID 0 is usually keyboard/mouse for player control.
  local isGamepadActive = (GetStickValue and Util.IsAnyButtonPressed(1))
    or Util.IsAnyGamepadButtonPressed(0)

  -- If mouse/keyboard is active, target is 0 (disable Xbox movement).
  -- Else if gamepad is active, target is 1 (enable Xbox movement).
  -- Else, target is nil (no change/update).
  local targetSettingValue = isMkbActive and 0 or isGamepadActive and 1 or nil
  return targetSettingValue
end

---Update setting
---@param targetInt integer
function AutoInputSwitch:UpdateXboxMovementSetting(targetInt)
  local isBullyBytesLoaded = Util.IsBullyBytesLoaded()
  local currentValue = Util.ConvertUdataInt32Value(self._ctrlPtr)

  if currentValue == targetInt then return end

  local inverse = targetInt == 1 and 0 or 1
  local oldCtrl = self:GetCurrentController()

  if isBullyBytesLoaded then
    SetInt32(self._ctrlPtr, targetInt)
    SetInt32(self._xboxMovePtr, inverse)
  else
    self._ctrlPtr.int32 = targetInt
    self._xboxMovePtr.int32 = inverse
  end

  local newCtrl = self:GetCurrentController()
  self._eventManager:Emit('OnControllerChanged', newCtrl, oldCtrl)
end

-- -------------------------------------------------------------------------- --
-- Getters                                                                    --
-- -------------------------------------------------------------------------- --

---@return 'keyboard'|'gamepad'
function AutoInputSwitch:GetCurrentController()
  local ctrl = Util.ConvertUdataInt32Value(self._ctrlPtr)
  return ctrl == 0 and 'keyboard' or 'gamepad'
end

---@return boolean
function AutoInputSwitch:GetXboxMovementEnabled()
  local settingValue = Util.ConvertUdataInt32Value(self._xboxMovePtr)
  return settingValue == 0
end

---@return userdata
function AutoInputSwitch:GetXboxMovementPointer()
  return self._xboxMovePtr
end

---@return userdata
function AutoInputSwitch:GetControllerPointer()
  return self._ctrlPtr
end

---@return EventManager
function AutoInputSwitch:GetEventManager()
  return self._eventManager
end

---@return boolean
function AutoInputSwitch:IsEnabled()
  return self.isEnabled
end

-- -------------------------------------------------------------------------- --
-- Setters                                                                    --
-- -------------------------------------------------------------------------- --

---Enable auto input switch
---@param enable boolean?
function AutoInputSwitch:SetEnabled(enable)
  local oldState = self.isEnabled
  self.isEnabled = enable ~= false

  if oldState == self.isEnabled then return end
  self._eventManager:Emit('OnAutoSwitchStateChanged', self.isEnabled, oldState)
end

-- -------------------------------------------------------------------------- --
-- Save to Global Variable                                                    --
-- -------------------------------------------------------------------------- --

ais.Class.AutoInputSwitch = AutoInputSwitch
