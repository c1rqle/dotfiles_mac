-- Toggle diagnostics with Alt+J
hs.hotkey.bind({"cmd"}, "j", function()
  hs.execute("nvr --remote-send '<cmd>ToggleDiagnostics<CR>'", true)
end)
-------------------------------
-- Reload Hammerspoon config at save --<D-j><D-j>
-------------------------------

local function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
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

-- Set path to yabai (assuming Homebrew installation)
local yabai = "/opt/homebrew/bin/yabai"

-------------------------------
-- General Service Management --
-------------------------------
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "r", function()
  hs.execute(yabai .. " --restart-service")
end)

---------------------------------
-- Window Navigation (Vim Keys) --
---------------------------------
hs.hotkey.bind({"alt"}, "h", function() hs.execute(yabai .. " -m window --focus west") end)
hs.hotkey.bind({"alt"}, "j", function() hs.execute(yabai .. " -m window --focus south") end)
hs.hotkey.bind({"alt"}, "k", function() hs.execute(yabai .. " -m window --focus north") end)
hs.hotkey.bind({"alt"}, "l", function() hs.execute(yabai .. " -m window --focus east") end)

---------------------------------
-- Window Manipulation & Layout --
---------------------------------
-- Float window and center
hs.hotkey.bind({"alt"}, "c", function()
  hs.execute(yabai .. " -m window --toggle float")
  hs.execute(yabai .. " -m window --grid 6:6:1:1:4:4")
end)

-- Fullscreen/parent/split toggles
hs.hotkey.bind({"alt"}, "f", function() hs.execute(yabai .. " -m window --toggle zoom-fullscreen") end)
hs.hotkey.bind({"alt"}, "z", function() hs.execute(yabai .. " -m window --toggle zoom-parent") end)
hs.hotkey.bind({"alt"}, "x", function() hs.execute(yabai .. " -m window --toggle split") end)

-- Sticky and balance
hs.hotkey.bind({"alt"}, "s", function() hs.execute(yabai .. " -m window --toggle sticky") end)
hs.hotkey.bind({"alt"}, "b", function() hs.execute(yabai .. " -m space --balance") end)

-- Warp windows between displays
hs.hotkey.bind({"alt", "ctrl"}, "h", function() hs.execute(yabai .. " -m window --warp west") end)
hs.hotkey.bind({"alt", "ctrl"}, "j", function() hs.execute(yabai .. " -m window --warp south") end)
hs.hotkey.bind({"alt", "ctrl"}, "k", function() hs.execute(yabai .. " -m window --warp north") end)
hs.hotkey.bind({"alt", "ctrl"}, "l", function() hs.execute(yabai .. " -m window --warp east") end)

-------------------------
-- Space/Desktop Focus --
-------------------------
-- Recent space
hs.hotkey.bind({"cmd"}, "e", function() hs.execute(yabai .. " -m space --focus recent") end)

-- Spaces 1-9 (universal)
for i = 1, 9 do
  hs.hotkey.bind({"cmd"}, tostring(i), function()
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
-- Window Movement Between Spaces
---------------------------------
for i = 1, 9 do
  hs.hotkey.bind({"shift", "cmd"}, tostring(i), function()
    hs.execute(yabai .. " -m window --space " .. i .. " && " .. yabai .. " -m space --focus " .. i)
  end)
end

-----------------------------
-- Space Creation/Destruction
-----------------------------
-- Create new space with window
hs.hotkey.bind({"cmd", "shift"}, "n", function()
  hs.execute([[ /bin/bash -c '
    yabai -m space --create
    index=$(yabai -m query --spaces --display | jq "map(select(.\"is-native-fullscreen\" == false))[-1].index")
    yabai -m window --space $index
    yabai -m space --focus $index
  ' ]])
end)

-- Destroy last space
hs.hotkey.bind({"cmd", "shift"}, "m", function()
  hs.execute([[ /bin/bash -c '
    index=$(yabai -m query --spaces | jq "map(select(.\"is-native-fullscreen\" == false))[-1].index")
    yabai -m space --destroy $index
    next_index=$(yabai -m query --spaces | jq "map(select(.\"is-native-fullscreen\" == false))[0].index")
    yabai -m space --focus $next_index
  ' ]])
end)

-- 
-- 
--  
-- -- #Define the combined modifier ({"ctrl", "alt"}, "h")
-- local combinedModifier = ({"ctrl", "alt"}, "h", function()
--   
-- end()
-- 
-- hs.hotkey.bind({"ctrl", "shift"}, "k", function()
--   hs.execute([[ /bin/bash -c '
--     index=$(yabai -m query --spaces | jq "map(select(.\"is-native-fullscreen\" == false))[-1].index")
--     yabai -m space --destroy $index
--     next_index=$(yabai -m query --spaces | jq "map(select(.\"is-native-fullscreen\" == false))[0].index")
--     yabai -m space --focus $next_index
--   ' ]])
-- end)
-- -- -- Global variables to prevent garbage collection
-- -- mouseMoveTap = hs.eventtap.new({hs.eventtap.event.types.leftMouseDragged}, function(event)
-- --     if hs.eventtap.checkKeyboardModifiers(combinedModifier) then
-- --         hs.execute("yabai -m window --move")
-- --         return true -- Consume the event
-- --     end
-- --     return false
-- -- end):start()
-- -- 
-- -- mouseResizeTap = hs.eventtap.new({hs.eventtap.event.types.rightMouseDragged}, function(event)
-- --     if hs.eventtap.checkKeyboardModifiers(combinedModifier) then
-- --         hs.execute("yabai -m window --resize")
-- --         return true -- Consume the event
-- --     end
-- --     return false
-- -- end):start()
-- -- 
-- --
-- -- 
