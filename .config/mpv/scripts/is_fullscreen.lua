local subsize = mp.get_property_native("sub-font-size")

mp.observe_property("fullscreen", "bool", function(name, value)
    if value then
        mp.set_property_native("sub-font-size", subsize)
        mp.commandv("run", "sh", "-c", "brightness kboff")
    else
        mp.set_property_native("sub-font-size", subsize * 1.5)
    end
end)
