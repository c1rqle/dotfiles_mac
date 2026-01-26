  local yabai = {}
  local bin = "/Users/tb/.local/bin/yabai"
  
  function yabai.init(LeftRightHotkey)
      -- Window navigation
      LeftRightHotkey:bind({ "lalt" }, "h", function() hs.execute(bin .. " -m window --focus west") end)
      LeftRightHotkey:bind({ "lalt" }, "j", function() hs.execute(bin .. " -m window --focus south") end)
      LeftRightHotkey:bind({ "lalt" }, "k", function() hs.execute(bin .. " -m window --focus north") end)
      LeftRightHotkey:bind({ "lalt" }, "l", function() hs.execute(bin .. " -m window --focus east") end)
  
      -- Window states
      hs.hotkey.bind({ "cmd", "shift" }, "f", function() hs.execute(bin .. " -m window --grid 6:6:1:1:4:4") end)
      hs.hotkey.bind({ "cmd", "shift" }, "t", function() hs.execute(bin .. " -m window --toggle float") end)
      hs.hotkey.bind({ "cmd", "shift" }, "p", function() hs.execute(bin .. " -m window --toggle sticky") end)
      hs.hotkey.bind({ "cmd", "shift" }, "o", function() hs.execute(bin .. " -m window --toggle zoom-fullscreen") end)
      hs.hotkey.bind({ "cmd", "shift" }, "z", function() hs.execute(bin .. " -m window --toggle zoom-parent") end)
      hs.hotkey.bind({ "cmd", "shift" }, "x", function() hs.execute(bin .. " -m window --toggle split") end)
      hs.hotkey.bind({ "cmd", "shift" }, "b", function() hs.execute(bin .. " -m space --balance") end)
  
      -- Move/Warp windows
      hs.hotkey.bind({ "cmd", "alt" }, "h", function() hs.execute(bin .. " -m window --warp west") end)
      hs.hotkey.bind({ "cmd", "alt" }, "j", function() hs.execute(bin .. " -m window --warp south") end)
      hs.hotkey.bind({ "cmd", "alt" }, "k", function() hs.execute(bin .. " -m window --warp north") end)
      hs.hotkey.bind({ "cmd", "alt" }, "l", function() hs.execute(bin .. " -m window --warp east") end)
  
      -- Space Navigation (1-9)
      for i = 1, 9 do
          hs.hotkey.bind({ "cmd" }, tostring(i), function() hs.execute(bin .. " -m space --focus " .. i) end)
          hs.hotkey.bind({ "cmd", "shift" }, tostring(i), function() 
              hs.execute(bin .. " -m window --space " .. i .. " && " .. bin .. " -m space --focus " .. i) 
          end)
      end
  
      -- Create/Destroy Spaces
      hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "n", function() hs.execute(bin .. " -m space --create") end)
      hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "w", function() hs.execute(bin .. " -m space --destroy") end)
  
      -- Übersicht Toggle
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
              hs.timer.doAfter(0.15, function() hs.execute(bin .. " -m config external_bar " .. padding) end)
          end
      end)
  end
  
  return yabai
