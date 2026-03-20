local yabai = {}
local bin = "/Users/tb/.local/bin/yabai"

-- Helper: Force a boolean window state to on (true) or off (false)
-- Example states: "sticky", "float", "native-fullscreen", "zoom-fullscreen", "zoom-parent"
-- (Yabai uses --toggle <state> and query gives "is-<state>")
local function setWindowState(state, desiredOn)
	-- Query current focused window info
	local jsonStr, success = hs.execute(bin .. " -m query --windows --window")
	if not success or jsonStr == "" then
		hs.alert.show("Failed to query window state")
		return
	end

	local win = hs.json.decode(jsonStr)
	if not win then
		hs.alert.show("Invalid window JSON")
		return
	end

	-- The JSON key is "is-sticky", "is-floating", "has-parent-zoom", "is-native-fullscreen", etc.
	local jsonKey
	if state == "sticky" then
		jsonKey = "is-sticky"
	elseif state == "float" then
		jsonKey = "is-floating"
	elseif state == "native-fullscreen" then
		jsonKey = "is-native-fullscreen"
	elseif state == "zoom-fullscreen" then
		jsonKey = "has-fullscreen-zoom" -- note: this one is different
	elseif state == "zoom-parent" then
		jsonKey = "has-parent-zoom"
	else
		hs.alert.show("Unknown state: " .. state)
		return
	end

	local current = win[jsonKey] or false

	-- Only toggle if we're not already in the desired state
	if (desiredOn and not current) or (not desiredOn and current) then
		hs.execute(bin .. " -m window --toggle " .. state)
	end
end

function yabai.init(LeftRightHotkey)
	-- Window navigation (unchanged)
	LeftRightHotkey:bind({ "lalt" }, "h", function()
		hs.execute(bin .. " -m window --focus west")
	end)
	LeftRightHotkey:bind({ "lalt" }, "j", function()
		hs.execute(bin .. " -m window --focus south")
	end)
	LeftRightHotkey:bind({ "lalt" }, "k", function()
		hs.execute(bin .. " -m window --focus north")
	end)
	LeftRightHotkey:bind({ "lalt" }, "l", function()
		hs.execute(bin .. " -m window --focus east")
	end)

	-- Window states – original toggles (kept for compatibility)
	hs.hotkey.bind({ "cmd", "shift" }, "g", function()
		hs.execute(bin .. " -m window --grid 6:6:1:1:4:4")
	end)
	hs.hotkey.bind({ "cmd", "shift" }, "f", function()
		hs.execute(bin .. " -m window --toggle float")
	end)
	hs.hotkey.bind({ "cmd", "shift" }, "p", function()
		hs.execute(bin .. " -m window --toggle sticky")
	end)
	hs.hotkey.bind({ "cmd", "shift" }, "o", function()
		hs.execute(bin .. " -m window --toggle native-fullscreen") -- ← fixed!
	end)
	hs.hotkey.bind({ "cmd", "shift" }, "z", function()
		hs.execute(bin .. " -m window --toggle zoom-parent")
	end)
	hs.hotkey.bind({ "cmd", "shift" }, "x", function()
		hs.execute(bin .. " -m window --toggle split")
	end)
	hs.hotkey.bind({ "cmd", "shift" }, "b", function()
		hs.execute(bin .. " -m space --balance")
	end)

	-- Force ON / OFF variants – use these when you want to guarantee a state
	-- Sticky
	hs.hotkey.bind({ "cmd", "shift", "alt" }, "p", function() -- force sticky ON
		setWindowState("sticky", true)
	end)
	hs.hotkey.bind({ "cmd", "alt", "shift" }, "p", function() -- force sticky OFF (using same keys but order diff)
		setWindowState("sticky", false)
	end)

	-- Float
	hs.hotkey.bind({ "cmd", "shift", "alt" }, "f", function() -- force float ON
		setWindowState("float", true)
	end)
	hs.hotkey.bind({ "cmd", "alt", "shift" }, "f", function() -- force float OFF
		setWindowState("float", false)
	end)

	-- Native Fullscreen (green button style)
	hs.hotkey.bind({ "cmd", "shift", "alt" }, "o", function() -- force native fullscreen ON
		setWindowState("native-fullscreen", true)
	end)
	hs.hotkey.bind({ "cmd", "alt", "shift" }, "o", function() -- force native fullscreen OFF
		setWindowState("native-fullscreen", false)
	end)

	-- Move/Warp windows (unchanged)
	hs.hotkey.bind({ "cmd", "alt" }, "h", function()
		hs.execute(bin .. " -m window --warp west")
	end)
	hs.hotkey.bind({ "cmd", "alt" }, "j", function()
		hs.execute(bin .. " -m window --warp south")
	end)
	hs.hotkey.bind({ "cmd", "alt" }, "k", function()
		hs.execute(bin .. " -m window --warp north")
	end)
	hs.hotkey.bind({ "cmd", "alt" }, "l", function()
		hs.execute(bin .. " -m window --warp east")
	end)

	-- Space Navigation (1-9) – unchanged
	for i = 1, 9 do
		hs.hotkey.bind({ "cmd" }, tostring(i), function()
			hs.execute(bin .. " -m space --focus " .. i)
		end)
		hs.hotkey.bind({ "cmd", "shift" }, tostring(i), function()
			hs.execute(bin .. " -m window --space " .. i .. " && " .. bin .. " -m space --focus " .. i)
		end)
	end

	-- Create/Destroy Spaces – unchanged
	hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "n", function()
		hs.execute(bin .. " -m space --create")
	end)
	hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "w", function()
		hs.execute(bin .. " -m space --destroy")
	end)

	-- Übersicht Toggle – unchanged
	hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "m", function()
		local script = [[
              tell application "Übersicht"
                  set isHidden to hidden of widget id "simple-bar-index-jsx"
                  if isHidden then
                      set hidden of every widget to false
                  else
                      set hidden of every widget to true
                  end if
                  return (hidden of widget id "simple-bar-index-jsx") as string
              end tell
          ]]
		local ok, result = hs.osascript.applescript(script)
		if ok then
			local padding = (result == "true") and "all:32:0" or "all:0:0"
			hs.timer.doAfter(0.15, function()
				hs.execute(bin .. " -m config external_bar " .. padding)
			end)
		end
	end)
end

return yabai
