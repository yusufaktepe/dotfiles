-- https://github.com/AN3223/dotfiles/blob/master/.config/mpv/scripts/multisocket.lua
-- Creates a socket for every mpv instance. The sockets are named "mpvsocket"
-- followed by a number, i.e. mpvsocket5. The highest number is the most recent
-- instance, the lowest is the oldest.

i = 0
while true do
	filename = "/tmp/mpvsocket" .. i
	local file, msg, err = io.open(filename)
	if file == nil and err ~= 6 then -- 6 = socket (maybe not portable?)
		break
	else
		i = i + 1
	end
end

mp.set_property("input-ipc-server", filename)
mp.register_event("shutdown", function() os.remove(filename) end)

