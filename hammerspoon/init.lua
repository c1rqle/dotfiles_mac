-----------------------------
--- Enabling spoons
 hs.loadSpoon("ModalMgr", "HSKeybindings", "FnMate", "ReloadConfiguration", "fnutils")
--
local MiddleClickDragScroll = hs.loadSpoon("MiddleClickDragScroll"):start()
local LeftRightHotkey = hs.loadSpoon("LeftRightHotkey"):start()

local module = require("hs.libosascript")
local module = require("hs.osascript")
local module = require("hs.spaces")

-------------------------------
--- hs.ipc. enables the use of the hs commmand in the terminal
local USERDATA_TAG = "hs.ipc"
local module = require("hs.libipc")
local module = require("hs.ipc")

-------------------------------
--- Reload Hammerspoon config at save
local function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-------------------------------
--- App shortcuts
hs.hotkey.bind({ "cmd", "ctrl" }, "return", function()
	hs.application.launchOrFocus("ghostty.app")
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "e", function()
	hs.application.launchOrFocus("finder.app")
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "i", function()
	hs.application.launchOrFocus("Zen.app")
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "m", function()
	hs.application.launchOrFocus("Spotify.app")
end)

-------------------------------
-- Disable the default macOS hide functionality
  hs.hotkey.bind({"cmd"}, "h", function()
      local app = hs.application.frontmostApplication()
  end)
-------------------------------
-- And rebinding it ↑
  hs.hotkey.bind({"cmd", "shift", }, "-", function()
      hs.application.frontmostApplication():hide()
  end)

-------------------------------
-- Disable default Cmd+Q quit
local eventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()
    -- keyCode 12 corresponds to 'q'
    if keyCode == 12 and flags.cmd and not flags.shift then
        -- suppress Cmd+Q default action
        return true
    end
    return false
end)
eventtap:start()
-------------------------------
-- Bind Cmd+Shift+Q to quit the frontmost app
hs.hotkey.bind({"cmd", "shift"}, "q", function()
    local app = hs.application.frontmostApplication()
    if app then
        app:kill()
    end
end)

 LeftRightHotkey:bind({ "lcmd", "lalt" }, "h", function()
    hs.execute("osascript -e 'tell application id 'tracesOf.Uebersicht' to refresh' ")
  end)

-------------------------------
--- Yabai
  local yabai = "/Users/tb/.local/bin/yabai"
  
  hs.hotkey.bind({ "cmd", "alt" }, "r", function()
  	hs.execute(yabai .. " --restart-service")
  end)

---------------------------------
--- Window navigation. Binding it to "left CMD" to not break any system shortcuts 
  LeftRightHotkey:bind({ "lalt" }, "h", function()
    hs.execute(yabai .. " -m window --focus west")
  end)
----------
  LeftRightHotkey:bind({ "lalt" }, "j", function()
  	hs.execute(yabai .. " -m window --focus south")
  end)
----------
  LeftRightHotkey:bind({ "lalt" }, "k", function()
  	hs.execute(yabai .. " -m window --focus north")
  end)
----------
  LeftRightHotkey:bind({ "lalt" }, "l", function()
  	hs.execute(yabai .. " -m window --focus east")
  end)

---------------------------------
--- Window rules

---------------------------------
--- Float window and center
  hs.hotkey.bind({ "cmd", "shift" }, "f", function()
  	hs.execute(yabai .. " -m window --toggle float")
  	hs.execute(yabai .. " -m window --grid 6:6:1:1:4:4")
  end)
---------------------------------
--- Sticky/pin to top
  hs.hotkey.bind({ "cmd", "shift" }, "p", function()
  	hs.execute(yabai .. " -m window --toggle sticky")
  end)
---------------------------------
--- Fullscreen/parent/split toggles
  hs.hotkey.bind({ "cmd", "shift" }, "o", function()
  	hs.execute(yabai .. " -m window --toggle zoom-fullscreen")
  end)
----------
  hs.hotkey.bind({ "cmd", "shift" }, "z", function()
  	hs.execute(yabai .. " -m window --toggle zoom-parent")
  end)
----------
  hs.hotkey.bind({ "cmd", "shift" }, "x", function()
  	hs.execute(yabai .. " -m window --toggle split")
  end)

  hs.hotkey.bind({ "cmd", "shift" }, "b", function()
  	hs.execute(yabai .. " -m space --balance")
  end)

---------------------------------
--- Move apps around in space
  hs.hotkey.bind({ "cmd", "alt" }, "h", function()
  	hs.execute(yabai .. " -m window --warp west")
  end)
----------
  hs.hotkey.bind({ "cmd", "alt" }, "j", function()
  	hs.execute(yabai .. " -m window --warp south")
  end)
----------
  hs.hotkey.bind({ "cmd", "alt" }, "k", function()
  	hs.execute(yabai .. " -m window --warp north")
  end)
----------
  hs.hotkey.bind({ "cmd", "alt" }, "l", function()
  	hs.execute(yabai .. " -m window --warp east")
  end)

-------------------------
--- Navigate the spaces with cmd+1-9
  for i = 1, 9 do
  	hs.hotkey.bind({ "cmd" }, tostring(i), function()
  		hs.execute(yabai .. " -m space --focus " .. i)
  	end)
  end

---------------------------------
--- Move windows from space to space
  for i = 1, 9 do
  	hs.hotkey.bind({ "cmd", "shift" }, tostring(i), function()
  		hs.execute(yabai .. " -m window --space " .. i .. " && " .. yabai .. " -m space --focus " .. i)
  	end)
  end

-----------------------------
----- Create new space and move to it
  hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "n", function()
      local output, status = hs.execute("/Users/tb/.local/bin/yabai -m query --spaces")
      if status then
          local spaces = hs.json.decode(output)
          local prevCount = #spaces

          hs.execute("/Users/tb/.local/bin/yabai -m space --create")

          output, status = hs.execute("/Users/tb/.local/bin/yabai -m query --spaces")
          if status then
              spaces = hs.json.decode(output)
              if #spaces > prevCount then
                  hs.alert.show("Created space " .. spaces[#spaces].index)
              end
          end
      else
          hs.alert.show("Failed to create space")
      end
  end)
--
-----------------------------
--- Remove last space added
  hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "w", function()
    hs.execute("/Users/tb/.local/bin/yabai -m space --destroy")
  end)


