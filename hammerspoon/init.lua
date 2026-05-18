-- Load Spoons
hs.loadSpoon("ModalMgr", "HSKeybindings", "FnMate", "ReloadConfiguration", "fnutils")
local LeftRightHotkey = hs.loadSpoon("LeftRightHotkey"):start()

-- Load Modules
local system = require("modules.system")
local yabai = require("modules.yabai")
local apps = require("modules.apps")

-- Initialize Modules
apps.init()
yabai.init(LeftRightHotkey) -- Passing the spoon so yabai.lua can use it
system.init()

-- Config Watcher (Auto-Reload)
local function reloadConfig(files)
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			hs.reload()
			break
		end
	end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "~/dotfiles_mac/hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
