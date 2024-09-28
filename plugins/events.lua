AddEventHandler("OnPluginStart", function (event)
    PerformHTTPRequest("https://raw.githubusercontent.com/X4BNet/lists_vpn/main/input/datacenter/ASN.txt", ParseVPNList)
    PerformHTTPRequest("https://raw.githubusercontent.com/X4BNet/lists_vpn/main/input/vpn/ASN.txt", ParseVPNList)

    PopulateConfigData()
    if config:Fetch("connection-filter.Ping_Treshold.enable") then
        SetTimer(5000, PingCheckerTimer)
    end
    if config:Fetch("connection-filter.Gameevents_Filter.enable") then
        SetTimer(5000, GameEventsCheckerTimer)
    end
end)

AddEventHandler("OnPlayerConnectFull", function (event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end

    local ipaddr = player:GetIPAddress()

    if config:Fetch("connection-filter.BlockASN") then
        if VPN_ASNList[ip:GetASN(ipaddr)] then
            return player:Drop(DisconnectReason.Kicked)
        end
    end

    if IPSettings.blacklist then
        if IPSettings.list[ipaddr] then
            return player:Drop(DisconnectReason.Kicked)
        end
    else
        if not IPSettings.list[ipaddr] then
            return player:Drop(DisconnectReason.Kicked)
        end
    end

    if CountrySettings.blacklist then
        if CountrySettings.list[ip:GetIsoCode(ipaddr)] then
            return player:Drop(DisconnectReason.Kicked)
        end
    else
        if not CountrySettings.list[ip:GetIsoCode(ipaddr)] then
            return player:Drop(DisconnectReason.Kicked)
        end
    end

    checks[tostring(player:GetSteamID())] = 0
end)

AddEventHandler("OnClientDisconnect", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end

    checks[tostring(player:GetSteamID())] = nil
end)