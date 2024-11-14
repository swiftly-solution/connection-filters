checks = {}

function ParseVPNList(status, body, headers, err)
    if status < 200 or status > 299 then return end

    local splittedLines = string.split(body, "\n")
    for i=1,#splittedLines do
        local ASNStr = string.split(splittedLines[i], "#")[1]:trim():split("AS")[1]:trim()
        VPN_ASNList[ASNStr] = true
    end
end

function PopulateConfigData()
    IPSettings.blacklist = (config:Fetch("connection-filter.IP.mode") == "blacklist")
    local iplist = config:Fetch("connection-filter.IP.list")
    for i=1,#iplist do
        IPSettings.list[iplist[i]] = true
    end

    CountrySettings.blacklist = (config:Fetch("connection-filter.Country.mode") == "blacklist")
    local countrylist = config:Fetch("connection-filter.Country.list")
    for i=1, #countrylist do
        CountrySettings.list[countrylist[i]] = true
    end

    local immune_steamidslist = config:Fetch("connection-filter.Ping_Treshold.immune_steamids")
    for i=1, #immune_steamidslist do
        PingSettings.immune_steamids[immune_steamidslist[i]] = true
    end

    GameEventsSettings.ban = (config:Fetch("connection-filter.Gameevents_Filter.mode") == "ban")
    GameEventsSettings.events = config:Fetch("connection-filter.Gameevents_Filter.list")
end

function PingCheckerTimer()
    for i = 0, playermanager:GetPlayerCap() - 1, 1 do
        local player = GetPlayer(i)
        if not player then goto continue end
        if player:IsFakeClient() then goto continue end
        local steamid = tostring(player:GetSteamID())
        if PingSettings.immune_steamids[steamid] then goto continue end
        if not checks[steamid] then checks[steamid] = 0 end

        if not player:CCSPlayerController():IsValid() then return end
        local ping = player:CCSPlayerController().Ping
        if ping > config:Fetch("connection-filter.Ping_Treshold.max_ping") then
            checks[steamid] = checks[steamid] + 1
            if checks[steamid] >= config:Fetch("connection-filter.Ping_Treshold.checks_to_kick") then
                player:Drop(DisconnectReason.Timedout)
            end
        else
            if checks[steamid] > 0 then
                checks[steamid] = checks[steamid] - 1
            end
        end

        ::continue::
    end
end

function GameEventsCheckerTimer()
    if GetPluginState("admins") ~= PluginState_t.Started then return end

    for i = 0, playermanager:GetPlayerCap() - 1, 1 do
        local player = GetPlayer(i)
        if player then
            for j=1,#GameEventsSettings.events do
                if player:IsListeningToGameEvent(GameEventsSettings.events[j]) then
                    local event_name = GameEventsSettings.events[j]
                    if GameEventsSettings.ban then
                        server:Execute(string.format("sw_ban #%d 0 \"Cheating - Game Event #%d\"", i, j))
                        print("Player: " .. player:CBasePlayerController().PlayerName .. " is listening to: " .. event_name)
                    else
                        server:Execute(string.format("sw_kick #%d \"Cheating - Game Event #%d\"", i, j))
                    end
                end
            end
        end
    end
end
