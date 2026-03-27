local system = {}

function system.init()
	-- KDE Connect Restart
	hs.hotkey.bind({ "cmd", "ctrl" }, "K", function()
		local app = hs.application.get("KDE Connect")
		if app then
			app:kill()
		end
		hs.timer.doAfter(1, function()
			hs.application.open("KDE Connect")
		end)
		hs.alert.show("Restarted KDE Connect")
	end)

	-- Disable default Cmd+H, rebind to Cmd+Shift+-
	hs.hotkey.bind({ "cmd" }, "h", function() end)
	hs.hotkey.bind({ "cmd", "shift" }, "-", function()
		local app = hs.application.frontmostApplication()
		if app then
			app:hide()
		end
	end)

	-- Disable default Cmd+Q, rebind to Cmd+Shift+Q
	local qBlocker = hs.eventtap
		.new({ hs.eventtap.event.types.keyDown }, function(event)
			local flags = event:getFlags()
			if event:getKeyCode() == 12 and flags.cmd and not flags.shift then
				return true
			end
			return false
		end)
		:start()

	hs.hotkey.bind({ "cmd", "shift" }, "q", function()
		local app = hs.application.frontmostApplication()
		if app then
			app:kill()
		end
	end)

	--
	hs.hotkey.bind({ "cmd", "ctrl" }, "j", function()
		-- Store current mouse position to restore later if needed
		local oldPos = hs.mouse.absolutePosition()

		-- Trigger Mission Control
		hs.eventtap.keyStroke({ "ctrl" }, "up")

		-- Wait for Mission Control animation
		hs.timer.doAfter(0.15, function()
			-- Get the focused screen
			local screen = hs.screen.mainScreen()
			local frame = screen:fullFrame()

			-- Calculate desktop preview position
			-- The desktop previews are at the top, so we aim for the top center
			local previewX = frame.x + (frame.w / 2)
			local previewY = frame.y + 10 -- Adjust this value if needed

			-- Move to preview
			hs.mouse.absolutePosition(hs.geometry.point(previewX, previewY))

			-- Tiny movement to ensure hover is registered
			hs.timer.doAfter(0.03, function()
				hs.mouse.absolutePosition(hs.geometry.point(previewX + 2, previewY))

				-- Optional: Restore mouse position after a moment
				-- hs.timer.doAfter(0.5, function()
				--     hs.mouse.absolutePosition(oldPos)
				-- end)
			end)
		end)
	end)
end

return system
