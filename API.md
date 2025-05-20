# Auto Input Switch API Documentation

This document describes the functions exposed by the **Auto Input Switch** mod through the `AUTO_INPUT_SWITCH.API` table. This API allows other scripts to interact with the core functionalities of `AutoInputSwitch`, such as getting the current input status, relevant memory pointers, detecting input, and listening to status change events.

## Getting Instances

### `GetSingleton()`

Returns the main instance of the `AutoInputSwitch` class. This instance manages the mod's primary logic and state.

```lua
local autoInputSwitchInstance = AUTO_INPUT_SWITCH.API.GetSingleton()
```

- **Returns**: `AutoInputSwitch` - The AutoInputSwitch instance.

### `GetEventManager()`

Returns the instance of `EventManager` used by `AutoInputSwitch`. This is useful for adding or removing event listeners.

```lua
local eventManager = AUTO_INPUT_SWITCH.API.GetEventManager()
```

- **Returns**: `EventManager` - The EventManager instance.

## Input Status & Settings

### `GetCurrentController()`

Returns a string indicating the type of controller currently considered active by the mod (based on its input detection logic).

```lua
local currentController = AUTO_INPUT_SWITCH.API.GetCurrentController()
if currentController == 'gamepad' then
  print("Currently using Gamepad")
else
  print("Currently using Keyboard/Mouse")
end
```

- **Returns**: `'gamepad' | 'keyboard'` - The type of active controller.

### `GetXboxMovementEnabled()`

Returns a boolean indicating whether the in-game "Enable XBOX 360 Movement" setting is currently active. Note that in the context of this mod, a `true` value means gamepad analog movement is **active**, which corresponds to a memory value of `0`.

```lua
local isXboxMoveEnabled = AUTO_INPUT_SWITCH.API.GetXboxMovementEnabled()
if isXboxMoveEnabled then
  print("Xbox (analog) movement is active.")
else
  print("Xbox (analog) movement is not active.")
end
```

- **Returns**: `boolean` - `true` if analog movement is active, `false` otherwise.

## Memory Pointers

These functions return `userdata` pointers to memory locations within the game that are managed by the mod. This is typically only needed for debugging or advanced interaction.

### `GetXboxMovementPointer()`

Returns a `userdata` pointer to the memory location that controls the "Enable XBOX 360 Movement" setting.

```lua
local xboxMovePtr = AUTO_INPUT_SWITCH.API.GetXboxMovementPointer()
-- Use this pointer with functions like GetInt32/SetInt32 if BullyBytes is loaded
```

- **Returns**: `userdata` - Pointer to the Xbox movement setting.

### `GetControllerPointer()`

Returns a `userdata` pointer to the memory location that indicates the active input controller type (0 for KBM, 1 for Gamepad).

```lua
local ctrlPtr = AUTO_INPUT_SWITCH.API.GetControllerPointer()
-- Use this pointer with functions like GetInt32/SetInt32 if BullyBytes is loaded
```

- **Returns**: `userdata` - Pointer to the active controller setting.

## Direct Input Detection

These functions use internal utilities to detect if any input from the keyboard or gamepad has just been pressed.

### `GetAnyKeyboardKeyPressed()`

Checks if any keyboard key registered in the mod's utility list has just been pressed.

```lua
local pressedKey = AUTO_INPUT_SWITCH.API.GetAnyKeyboardKeyPressed()
if pressedKey then
  print("Keyboard key '" .. pressedKey .. "' was just pressed.")
end
```

- **Returns**: `string?` - The name of the pressed key, or `nil` if none.

### `GetAnyGamepadButtonPressed(ctrlId)`

Checks if any gamepad button registered in the mod's utility list has just been pressed for a specific controller ID.

```lua
local pressedButtonId = AUTO_INPUT_SWITCH.API.GetAnyGamepadButtonPressed(1) -- For Controller ID 1
if pressedButtonId then
  print("Gamepad button with ID " .. pressedButtonId .. " was just pressed on controller 1.")
end
```

- **Parameters**:
  - `ctrlId` (`0|1|2|3`): The controller ID to check.
- **Returns**: `integer?` - The ID of the pressed button, or `nil` if none.

## Event Handling

The API provides a way to listen for events emitted by the mod, such as changes in the active controller or the `AutoInputSwitch` status.

### `AddEventListener(eventName, callback)`

Adds a listener (callback function) for a specific event.

```lua
local function onControllerChanged(newController, oldController)
  print("Controller changed from " .. oldController .. " to " .. newController)
end

AUTO_INPUT_SWITCH.API.AddEventListener('OnControllerChanged', onControllerChanged)
```

- **Parameters**:
  - `eventName` (`string`): The name of the event to listen for. See the list of events below.
  - `callback` (`function`): The function to be called when the event occurs. The arguments received by the callback depend on the event.

### `RemoveEventListener(eventName, callback)`

Removes a listener (callback function) from a specific event. The provided callback must be the exact same function used during `AddEventListener`.

```lua
-- To remove the previously added listener:
AUTO_INPUT_SWITCH.API.RemoveEventListener('OnControllerChanged', onControllerChanged)
```

- **Parameters**:
  - `eventName` (`string`): The name of the event.
  - `callback` (`function`): The callback function to remove.
- **Returns**: `boolean` - `true` if the listener was successfully removed, `false` if it was not found.

## List of Events

The following events can be listened to using `AddEventListener`:

- `OnControllerChanged`: Emitted when the mod detects a change between Keyboard/Mouse and Gamepad input, and the in-game movement setting is updated.
  - Callback receives arguments: `(newController: 'keyboard'|'gamepad', oldController: 'keyboard'|'gamepad')`
- `OnAutoSwitchStateChanged`: Emitted when the `isEnabled` status of the `AutoInputSwitch` instance changes (e.g., via `SetEnabled`).
  - Callback receives arguments: `(isEnabled: boolean, oldState: boolean)`
