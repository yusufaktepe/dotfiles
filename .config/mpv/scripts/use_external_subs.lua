--[[
https://github.com/fxmarty/mpv-scripts/blob/main/use_external_subs.lua

Simple script to use only external subtitles as first and secondary sids
Example input.conf bind:
  UP script-binding switch-secondary
  n script-binding swap-sid-seconday-sid
]]--

two_externals = false
secondary_sid = -1

function find_default_external_sids()
    mp.get_property_native('track-list')
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

function initialize()
    subs_ids = {}
    for track_num, track in pairs(mp.get_property_native('track-list')) do
        if track['external'] == true and track['type'] == 'sub' then
            table.insert(subs_ids, track['id'])
        end
    end

    local nb_subs_ids = tablelength(subs_ids)

    if nb_subs_ids == 0 then
        print('No external subtitle found.')
    elseif nb_subs_ids == 1 then
        print('Found only one external subtitle found, and used it as first sid.')
        mp.set_property_number('sid', subs_ids[1])
        mp.set_property_bool('secondary-sid', false)
    elseif nb_subs_ids == 2 then
        print('Found two external subtitles, put them randomly as sid and secondary sid.')
        mp.set_property_number('sid', subs_ids[1])
        mp.set_property_number('secondary-sid', subs_ids[2])
        two_externals = true
        secondary_sid = subs_ids[2]
    else
        print('Found more than two external subtitles, be careful.')
        mp.set_property_number('sid', subs_ids[1])
        mp.set_property_number('secondary-sid', subs_ids[2])
    end
end

-- switch on/off the secondary subtitle
function switch_secondary()
    if two_externals == true then
        print(mp.get_property('secondary-sid'))
        if mp.get_property('secondary-sid') == 'no' then
            mp.set_property_number('secondary-sid', secondary_sid)
        else
            mp.set_property('secondary-sid', 'no')
        end
    else
        print('No secondary sid')
    end
end

-- in case the two sids were loaded in the wrong order
function swap_sid_secondary_sid()
    if two_externals == true then
        local current_sid = mp.get_property_native('sid')
        local current_sec_sid = mp.get_property_native('secondary-sid')
        mp.set_property('sid', 'no')
        mp.set_property('secondary-sid', 'no')
        mp.set_property_number('sid', current_sec_sid)
        mp.set_property_number('secondary-sid', current_sid)
        secondary_sid = current_sid
        print('Subtitle sid and secondary have been swapped.')
    else
        print('No secondary external subtitle.')
    end
end

-- mp.add_key_binding("UP", "switch-secondary", switch_secondary)
mp.add_key_binding("KP_PGDWN", "swap-sid-seconday-sid", swap_sid_secondary_sid)

mp.add_timeout(1.5, initialize) -- initialize after mpv has loaded the file
