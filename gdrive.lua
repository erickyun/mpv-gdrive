TOKEN = ""
OPTIONS = {}

-----------------------------
-- This script registers 2 hooks:
--   + on_load as the main entrypoint
--   + on_load_fail in case current access token expires and needs refreshing
-----------------------------

function on_load_hook()
    local path = mp.get_property("path", "")
    file_id = detect_gdrive_file_id(path)
    if file_id then
        print("Detected google drive link, rewriting stream-open-filename")
        direct_url = "https://www.googleapis.com/drive/v3/files/" .. file_id .. "?alt=media"
        mp.set_property("stream-open-filename", direct_url)

        OPTIONS = load_options()
        TOKEN = get_access_token(OPTIONS)
        set_auth_headers(TOKEN)

        -- Add "refresh token" hook iff this is an actual gdrive path
        mp.add_hook("on_load_fail", 50, on_load_fail_hook)
    else
    end

end

function on_load_fail_hook()
    -- In case token expires, refresh it
    print('Token failed, refreshing...')
    TOKEN = get_access_token(OPTIONS)
    set_auth_headers(TOKEN)
end

-- Apparently hooks are bad and unsupported but ytdl_hook uses them.
-- The alternative, register_event('start-file'), seems to be non-blocking
-- which may cause race conditions e.g. mpv trying to load a non-existent
-- gdrive:// protocol before this script sets the correct url.
mp.add_hook("on_load", 50, on_load_hook)



-----------------------------
-- GNARLY INTERNALS FOLLOW
-----------------------------


function detect_gdrive_file_id(path)
    if (path:find("gdrive://") == 1) then
        return path:sub(10) -- string.len("gdrive://") + 1
    elseif (path:find("https://drive.google.com/file/d/") == 1) then
        remainder = path:sub(33) -- string.len([stuff above]) + 1
        return remainder:sub(1, remainder:find("/") - 1)
    else
        return nil
    end
end


function set_auth_headers(access_token)
    print("Setting GDrive authorization headers")
    headers = {}
    headers[1] = "Authorization: Bearer " .. access_token
    mp.set_property_native("file-local-options/http-header-fields", headers)
end


function load_options()
    local options = require 'mp.options'
    local o = {
        gdrive_client_id = "",
        gdrive_client_secret = "",
        gdrive_refresh_token = "",
    }
    options.read_options(o, "gdrive")
    return o
end


function get_access_token(o)
    local utils = require 'mp.utils'

    request_body = (
        "client_id=" .. o.gdrive_client_id ..
        "&client_secret=" .. o.gdrive_client_secret ..
        "&refresh_token=" .. o.gdrive_refresh_token ..
        "&grant_type=refresh_token"
    )
    print("Requesting token for client_id", o.gdrive_client_id:sub(1, 10) .. "[...]")

    -- Shelling out to curl instead of using the luasec library because by
    -- default luasec doesn't verify CA cert, and the non-default API is messy.
    -- Also requiring curl as a dependency is probably an easier sell than
    -- telling end-users to install some lua package.
    ret = mp.command_native({
        name = "subprocess",
        args = {
            "curl", "-s", "-X", "POST",
            "https://www.googleapis.com/oauth2/v4/token",
            "-H", "Accept: application/json",
            "-H", "Content-Type: application/x-www-form-urlencoded",
            "-d", request_body
        },
        capture_stdout=true
    })
    local resp_json, err = utils.parse_json(ret.stdout)
    access_token = resp_json["access_token"]
    print("Received access_token", access_token:sub(1, 10) .. "[...]")
    return access_token
end
