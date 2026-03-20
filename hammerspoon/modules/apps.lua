local apps = {}

local function toggleApp(appName)
	local app = hs.application.get(appName)

	if app and app:isFrontmost() then
		app:hide()
	else
		hs.application.launchOrFocus(appName)

		hs.timer.doAfter(0.1, function()
			-- Moves window to current space/display via Yabai
			hs.execute(
				"/Users/tb/.local/bin/yabai -m window --space mouse && /Users/tb/.local/bin/yabai -m window --display mouse"
			)

			local win = hs.window.focusedWindow()
			if win then
				win:focus()
			end
		end)
	end
end

function apps.init()
	-- App shortcuts
	hs.hotkey.bind({ "cmd", "ctrl" }, "return", function()
		toggleApp("Ghostty")
	end)
	hs.hotkey.bind({ "cmd", "ctrl" }, "f", function()
		toggleApp("Finder")
	end)
	hs.hotkey.bind({ "cmd", "ctrl" }, "i", function()
		toggleApp("Arc")
	end)
	hs.hotkey.bind({ "cmd", "ctrl" }, "m", function()
		toggleApp("Spotify")
	end)
	hs.hotkey.bind({ "cmd", "ctrl" }, "d", function()
		toggleApp("Bitwarden")
	end)
	hs.hotkey.bind({ "cmd", "ctrl" }, "e", function()
		toggleApp("Tuta Mail")
	end)
	hs.hotkey.bind({ "cmd", "ctrl" }, "c", function()
		toggleApp("Claude")
	end)
	hs.hotkey.bind({ "cmd", "ctrl" }, "g", function()
		toggleApp("ChatGPT")
	end)
end

return apps
