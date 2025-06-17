hs.loadSpoon("ModalMgr", "HSKeybindings")
local MiddleClickDragScroll = hs.loadSpoon("MiddleClickDragScroll"):start()

-------------------------------
-- Reload Hammerspoon config at save --<D-j><D-j>
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
    -- Get the current application
    local app = hs.application.frontmostApplication()
    -- You could replace this with your own function
    hs.alert.show("Hide disabled for " .. app:name())
end)

hs.hotkey.bind({"cmd", "shift", }, "-", function()
    hs.application.frontmostApplication():hide()
end)
-------------------------------
-- Yabai
local yabai = "/opt/homebrew/bin/yabai"

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "r", function()
	hs.execute(yabai .. " --restart-service")
end)

-- -------------------------------
-- Navigation
hs.hotkey.bind({ "cmd" }, "h", function()
	hs.execute(yabai .. " -m window --focus west")
end)
hs.hotkey.bind({ "cmd" }, "j", function()
	hs.execute(yabai .. " -m window --focus south")
end)
hs.hotkey.bind({ "cmd" }, "k", function()
	hs.execute(yabai .. " -m window --focus north")
end)
hs.hotkey.bind({ "cmd" }, "l", function()
	hs.execute(yabai .. " -m window --focus east")
end)

---------------------------------
-- Window Manipulation & Layout --
-- Float window and center
hs.hotkey.bind({ "cmd", "ctrl" }, "c", function()
	hs.execute(yabai .. " -m window --toggle float")
	hs.execute(yabai .. " -m window --grid 6:6:1:1:4:4")
end)

---------------------------------
-- Fullscreen/parent/split toggles
hs.hotkey.bind({ "cmd", "ctrl" }, "f", function()
	hs.execute(yabai .. " -m window --toggle zoom-fullscreen")
end)
hs.hotkey.bind({ "cmd", "ctrl" }, "z", function()
	hs.execute(yabai .. " -m window --toggle zoom-parent")
end)
hs.hotkey.bind({ "cmd", "ctrl" }, "x", function()
	hs.execute(yabai .. " -m window --toggle split")
end)

---------------------------------
-- Sticky/pin to top and balance
hs.hotkey.bind({ "cmd", "ctrl" }, "p", function()
	hs.execute(yabai .. " -m window --toggle sticky")
end)
hs.hotkey.bind({ "cmd", "ctrl" }, "b", function()
	hs.execute(yabai .. " -m space --balance")
end)

---------------------------------
-- switch places for windows
hs.hotkey.bind({ "cmd", "alt" }, "h", function()
	hs.execute(yabai .. " -m window --warp west")
end)
hs.hotkey.bind({ "cmd", "alt" }, "j", function()
	hs.execute(yabai .. " -m window --warp south")
end)
hs.hotkey.bind({ "cmd", "alt" }, "k", function()
	hs.execute(yabai .. " -m window --warp north")
end)
hs.hotkey.bind({ "cmd", "alt" }, "l", function()
	hs.execute(yabai .. " -m window --warp east")
end)

-------------------------
-- Space/Desktop Focus --
-------------------------

-------------------------
-- Spaces 1-9 (universal)
for i = 1, 9 do
	hs.hotkey.bind({ "cmd" }, tostring(i), function()
		hs.execute(yabai .. " -m space --focus " .. i)
	end)
end

-- -- External monitor spaces (5-8)
-- hs.hotkey.bind({"cmd"}, "5", function()
--   hs.execute(yabai .. " -m display --focus 2 && " .. yabai .. " -m space --focus 5")
-- end)
-- hs.hotkey.bind({"cmd"}, "6", function()
--   hs.execute(yabai .. " -m display --focus 2 && " .. yabai .. " -m space --focus 6")
-- end)
-- hs.hotkey.bind({"cmd"}, "7", function()
--   hs.execute(yabai .. " -m display --focus 2 && " .. yabai .. " -m space --focus 7")
-- end)
-- hs.hotkey.bind({"cmd"}, "8", function()
--   hs.execute(yabai .. " -m display --focus 2 && " .. yabai .. " -m space --focus 8")
-- end)
--
---------------------------------
-- Window Movement Between Spaces (i.e cmd+shift+2 moves focused window to space 2)
---------------------------------
for i = 1, 9 do
	hs.hotkey.bind({ "cmd", "shift" }, tostring(i), function()
		hs.execute(yabai .. " -m window --space " .. i .. " && " .. yabai .. " -m space --focus " .. i)
	end)
end

-----------------------------
-- Space Creation/Destruction
-----------------------------
-- Create new space with window
hs.hotkey.bind({"ctrl", "cmd"}, "n", function()
    -- Get current space count before creating new one
    local output, status = hs.execute("/usr/local/bin/yabai -m query --spaces")
    
    if status then
        local spaces = hs.json.decode(output)
        local prevCount = #spaces
        
        -- Create new space
        hs.execute("/usr/local/bin/yabai -m space --create")
        
        -- Verify creation
        output, status = hs.execute("/usr/local/bin/yabai -m query --spaces")
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
-- Destroy last space
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "w", function()
	hs.execute([[ /bin/bash -c '
    index=$(yabai -m query --spaces | jq "map(select(.\"is-native-fullscreen\" == false))[-1].index")
    yabai -m space --destroy $index
    next_index=$(yabai -m query --spaces | jq "map(select(.\"is-native-fullscreen\" == false))[0].index")
    yabai -m space --focus $next_index
  ' ]])
end)
