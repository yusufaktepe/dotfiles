local mp = require "mp"

local normal_scale = mp.get_property_number("sub-scale", 1.0)
local windowed_scale = normal_scale * 1.5
local last_state = nil

mp.observe_property("fullscreen", "bool", function(_, fullscreen)
    if fullscreen == last_state then
        return
    end
    last_state = fullscreen

    mp.set_property_number(
        "sub-scale",
        fullscreen and normal_scale or windowed_scale
    )

    if fullscreen then
        -- io.popen with a trailing '&' handles execution purely via OS fork.
        -- This isolates the thread completely from the amdgpu HMM space.
        local pipe = io.popen("brightness kboff &")
        if pipe then pipe:close() end
    end
end)
