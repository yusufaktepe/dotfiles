local mp = require 'mp'

local function get_sub_tracks()
    local tracks = mp.get_property_native("track-list", {})
    local sub_tracks = {}

    for _, track in ipairs(tracks) do
        if track.type == "sub" and track.lang then
            sub_tracks[track.lang] = track.id
        end
    end

    return sub_tracks
end

local function cycle_subtitles()
    local sub_tracks = get_sub_tracks()
    local current_sid = mp.get_property_number("sid", 0)

    if (sub_tracks["tur"] or sub_tracks["tr"]) and (sub_tracks["eng"] or sub_tracks["en"]) then
        local tur_id = sub_tracks["tur"] or sub_tracks["tr"]
        local eng_id = sub_tracks["eng"] or sub_tracks["en"]

        if current_sid == eng_id then
            mp.set_property("sid", tur_id)
        else
            mp.set_property("sid", eng_id)
        end
    end
end

-- Bind the function to a key (e.g., "y")
mp.add_key_binding("KP_PGDWN", "cycle_subtitles", cycle_subtitles)

