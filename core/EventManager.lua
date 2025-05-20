-- -------------------------------------------------------------------------- --
-- EventManager Class                                                         --
-- -------------------------------------------------------------------------- --

---@class EventManager
---@field private _listeners table<string, EventManager_ListenerTable[]>
local EventManager = {}
EventManager.__index = EventManager

-- -------------------------------------------------------------------------- --
-- Constructor                                                                --
-- -------------------------------------------------------------------------- --

function EventManager.new()
  local instance = setmetatable({}, EventManager)
  instance._listeners = {}
  return instance
end

-- -------------------------------------------------------------------------- --
-- Methods                                                                    --
-- -------------------------------------------------------------------------- --

---@param name string
---@param callback EventManager_EventCallback
function EventManager:AddListener(name, callback)
  if not self._listeners[name] then self._listeners[name] = {} end
  local udata = RegisterLocalEventHandler('AutoInputSwitch:' .. name, callback)
  local listenerTbl = { callback = callback, dslEventUserdata = udata }
  table.insert(self._listeners[name], listenerTbl)
end

---@param name string
---@param ... any
function EventManager:Emit(name, ...)
  if not self._listeners[name] then return end
  RunLocalEvent('AutoInputSwitch:' .. name, unpack(arg)) -- DSL event
  -- for _, listenerTbl in ipairs(self._listeners[name]) do
  --   listenerTbl.callback(unpack(arg)) -- This mod custom event implementation
  -- end
end

---@param name string
---@param callback? EventManager_EventCallback
---@param dslEventUserdata? userdata
---@return boolean success
function EventManager:RemoveListener(name, callback, dslEventUserdata)
  if not self._listeners[name] then return false end
  if not callback and not dslEventUserdata then return false end
  for index, l in ipairs(self._listeners[name]) do
    if l.callback == callback or l.dslEventUserdata == dslEventUserdata then
      table.remove(self._listeners[name], index) -- Remove the listener table
      RemoveEventHandler(l.dslEventUserdata) -- Remove DSL event handler
      return true
    end
  end
  return false
end

-- -------------------------------------------------------------------------- --
-- Export                                                                     --
-- -------------------------------------------------------------------------- --

AUTO_INPUT_SWITCH.Class.EventManager = EventManager

-- -------------------------------------------------------------------------- --
-- Type Definitions                                                           --
-- -------------------------------------------------------------------------- --

---@alias EventManager_EventCallback fun(...: any): any
---@alias EventManager_ListenerTable { callback: EventManager_EventCallback, dslEventUserdata: userdata }
