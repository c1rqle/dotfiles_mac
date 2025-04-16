package.cpath = package.cpath .. ";~/.local/share/sketchybar_lua/?.so"
local sbar = require("sketchybar")

local bar = sbar.bar {
  position = "bottom",
  height = 26,
  color = 0xFF1E1E2E,
  margin = 10,
}

-- Clock
bar:add("clock", {
  position = "right",
  label = os.date("%H:%M"),
  update_freq = 60,
  update = function(self)
    self:set({ label = os.date("%H:%M") })
  end
})

-- Spacer (for padding)
bar:add("spacer", {
  position = "left",
  width = 10
})

-- CPU Usage
bar:add("cpu", {
  position = "right",
  icon = "", -- or pick any nerd font icon
  update_freq = 5,
  update = function(self)
    local usage = io.popen("ps -A -o %cpu | awk '{s+=$1} END {print s}'"):read("*a")
    usage = tonumber(usage) or 0
    self:set({ label = string.format("%.0f%%", usage) })
  end
})
