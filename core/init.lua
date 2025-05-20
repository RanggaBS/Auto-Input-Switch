-- -------------------------------------------------------------------------- --
-- Create Mod's Root Global Variable                                          --
-- -------------------------------------------------------------------------- --

_G.AUTO_INPUT_SWITCH = {
  XBOX_MOVE_PTR = nil, --[[@as userdata]]
  CTRL_PTR = nil, --[[@as userdata]]

  autoInputSwitch = nil, --[[@as AutoInputSwitch]]

  Class = {},

  Util = nil, --[[@as Util]]

  Thread = {
    Init = nil --[[@as thread]],
    Main = nil --[[@as thread]],
  },

  API = {},
}

-- -------------------------------------------------------------------------- --
-- Load Scripts                                                               --
-- -------------------------------------------------------------------------- --

local files = {
  { path = 'utils/', name = 'Util' },
  { path = 'core/', name = 'EventManager' },
  { path = 'core/', name = 'AutoInputSwitch' },
}

for _, file in ipairs(files) do
  LoadScript(file.path .. file.name .. '.lua')
end
