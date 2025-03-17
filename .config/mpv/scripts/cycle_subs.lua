local mp = require 'mp'

local function get_sub_tracks()
    local tracks = mp.get_property_native("track-list", {})
    local sub_tracks = {}

    for _, track in ipairs(tracks) do
        -- Skip forced subtitles
        -- if track.type == "sub" and track.lang and not track.forced then
            -- Only set the language if it's not already set to prioritize the first non-forced occurrence
            if (track.lang == "tur" or track.lang == "tr") and not sub_tracks["tur"] then
            -- if (track.lang == "tur" or track.lang == "tr") then
                sub_tracks["tur"] = track.id
            elseif (track.lang == "eng" or track.lang == "en") and not sub_tracks["eng"] then
            -- elseif (track.lang == "eng" or track.lang == "en") then
                sub_tracks["eng"] = track.id
            end
        -- end
    end

    return sub_tracks
end

local function cycle_subtitles()
    local sub_tracks = get_sub_tracks()
    local current_sid = mp.get_property_number("sid", 0)

    if (sub_tracks["tur"]) and (sub_tracks["eng"]) then
        local tur_id = sub_tracks["tur"]
        local eng_id = sub_tracks["eng"]

        if current_sid == eng_id then
            mp.set_property("sid", tur_id)
        else
            mp.set_property("sid", eng_id)
        end
    end
end

-- Bind the function to a key (e.g., "KP_PGDWN")
mp.add_key_binding("KP_PGDWN", "cycle_subtitles", cycle_subtitles)

