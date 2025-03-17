local mp = require 'mp'

local subscale = mp.get_property_native("sub-scale", 1.0)

mp.observe_property("fullscreen", "bool", function(name, value)
    if value then
        mp.set_property("sub-scale", subscale)
        mp.commandv("run", "sh", "-c", "brightness kboff")
    else
        mp.set_property("sub-scale", subscale * 1.5)
    end
end)
