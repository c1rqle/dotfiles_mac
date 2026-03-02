  local system = {}
  
  function system.init()
      -- KDE Connect Restart
      hs.hotkey.bind({"cmd", "ctrl"}, "K", function()
          local app = hs.application.get("KDE Connect")
          if app then app:kill() end
          hs.timer.doAfter(1, function() hs.application.open("KDE Connect") end)
          hs.alert.show("Restarted KDE Connect")
      end)
  
      -- Disable default Cmd+H, rebind to Cmd+Shift+-
      hs.hotkey.bind({"cmd"}, "h", function() end) 
      hs.hotkey.bind({"cmd", "shift"}, "-", function()
          local app = hs.application.frontmostApplication()
          if app then app:hide() end
      end)
  
      -- Disable default Cmd+Q, rebind to Cmd+Shift+Q
      local qBlocker = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
          local flags = event:getFlags()
          if event:getKeyCode() == 12 and flags.cmd and not flags.shift then return true end
          return false
      end):start()
  
      hs.hotkey.bind({"cmd", "shift"}, "q", function()
          local app = hs.application.frontmostApplication()
          if app then app:kill() end
      end)
  end
  
  return system
