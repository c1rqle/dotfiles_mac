-------------------------------
--- Enabling spoons
hs.loadSpoon("ModalMgr", "HSKeybindings")
local MiddleClickDragScroll = hs.loadSpoon("MiddleClickDragScroll"):start()
local LeftRightHotkey = hs.loadSpoon("LeftRightHotkey"):start()

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

hs.hotkey.bind({ "cmd", "ctrl" }, "f", function()
	hs.application.launchOrFocus("finder.app")
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "å", function()
  hs.application.launchOrFocus("ChatGPT.app")
end)

-------------------------------
-- Disable the default macOS hide functionality
hs.hotkey.bind({"cmd"}, "h", function()
    local app = hs.application.frontmostApplication()
    hs.alert.show("Hide disabled for " .. app:name())
end)

-------------------------------
-- And rebinding it ↑
hs.hotkey.bind({"cmd", "shift", }, "-", function()
    hs.application.frontmostApplication():hide()
end)

-------------------------------
--- Yabai
local yabai = "/Users/tb/.local/bin/yabai"

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "r", function()
	hs.execute(yabai .. " --restart-service")
end)

---------------------------------
--- Window navigation. Binding it to "left CMD" to not break any system shortcuts 
  LeftRightHotkey:bind({ "lcmd" }, "h", function()
    hs.execute(yabai .. " -m window --focus west")
  end)
----------
  LeftRightHotkey:bind({ "lCmd" }, "j", function()
  	hs.execute(yabai .. " -m window --focus south")
  end)
----------
  LeftRightHotkey:bind({ "lCmd" }, "k", function()
  	hs.execute(yabai .. " -m window --focus north")
  end)
----------
  LeftRightHotkey:bind({ "lCmd" }, "l", function()
  	hs.execute(yabai .. " -m window --focus east")
  end)

---------------------------------
--- Window rules

---------------------------------
--- Float window and center
  hs.hotkey.bind({ "cmd", "shift" }, "c", function()
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
  hs.hotkey.bind({ "cmd", "shift" }, "f", function()
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

---------------------------------
--- Make windows in a space equal size
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

---------------------------------
--- Forcing space 5-8 to an external monitor if one is connected
 hs.hotkey.bind({"cmd"}, "5", function()
   hs.execute(yabai .. " -m display --focus 2 && " .. yabai .. " -m space --focus 5")
 end)
----------
 hs.hotkey.bind({"cmd"}, "6", function()
   hs.execute(yabai .. " -m display --focus 2 && " .. yabai .. " -m space --focus 6")
 end)
----------
 hs.hotkey.bind({"cmd"}, "7", function()
   hs.execute(yabai .. " -m display --focus 2 && " .. yabai .. " -m space --focus 7")
 end)
----------
 hs.hotkey.bind({"cmd"}, "8", function()
   hs.execute(yabai .. " -m display --focus 2 && " .. yabai .. " -m space --focus 8")
 end)

-----------------------------
--- Create new space and move to it
  hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "n", function()
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

-----------------------------
--- Remove last space added
  hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "w", function()
  	hs.execute([[ /bin/bash -c '
      index=$(yabai -m query --spaces | jq "map(select(.\"is-native-fullscreen\" == false))[-1].index")
      yabai -m space --destroy $index
      next_index=$(yabai -m query --spaces | jq "map(select(.\"is-native-fullscreen\" == false))[0].index")
      yabai -m space --focus $next_index
    ' ]])
  end)
