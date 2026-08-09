local mp = require "mp"

mp.register_script_message("run", function(...)
    local args = {...}

    mp.add_timeout(0.1, function()
        mp.command_native_async({
            name = "subprocess",
            playback_only = false,
            detach = true,
            args = args,
        })
    end)
end)
