local mp = require 'mp'

-- Helper to detect SDH subtitles based on title
local function is_sdh(track)
    if not track.title then return false end
    local title = track.title:lower()
    return title:find("sdh") or title:find("hearing") or title:find("impaired")
end

local function get_sub_tracks()
    local tracks = mp.get_property_native("track-list", {})

    local sub_tracks = {
        eng = nil,
        tur = nil
    }

    local fallback_sdh = {
        eng = nil,
        tur = nil
    }

    local fallback_forced = {
        eng = nil,
        tur = nil
    }

    for _, track in ipairs(tracks) do
        if track.type == "sub" and track.lang then
            local lang = nil
            if track.lang == "eng" or track.lang == "en" then
                lang = "eng"
            elseif track.lang == "tur" or track.lang == "tr" then
                lang = "tur"
            end

            if lang then
                if not is_sdh(track) and not track.forced then
                    sub_tracks[lang] = track.id  -- clean subtitle (overwrite to prefer last)
                elseif is_sdh(track) and not track.forced then
                    fallback_sdh[lang] = track.id  -- SDH fallback (last wins)
                elseif track.forced then
                    fallback_forced[lang] = track.id  -- forced fallback (last wins)
                end
            end
        end
    end

    -- Use fallback if no clean track found
    for _, lang in ipairs({ "eng", "tur" }) do
        if not sub_tracks[lang] then
            sub_tracks[lang] = fallback_sdh[lang] or fallback_forced[lang]
        end
    end

    return sub_tracks
end

local function cycle_subtitles()
    local sub_tracks = get_sub_tracks()
    local current_sid = mp.get_property_number("sid", 0)

    if sub_tracks["tur"] and sub_tracks["eng"] then
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

