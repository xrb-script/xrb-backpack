local RESOURCE_NAME = GetCurrentResourceName()

local function getWeightForDrawable(drawableId)
    local maxWeight = Config.DefaultMaxWeight

    for _, bag in ipairs(Config.BagTypes) do
        if bag.drawable == drawableId then
            maxWeight = Config.DefaultMaxWeight + (bag.weight * 1000)
            break
        end
    end

    return maxWeight
end

local function applyPlayerWeight(playerId, drawableId)
    if not playerId or playerId <= 0 then
        return
    end

    exports.ox_inventory:SetMaxWeight(playerId, getWeightForDrawable(tonumber(drawableId) or 0))
end

local function resetPlayerWeight(playerId)
    if not playerId or playerId <= 0 then
        return
    end

    exports.ox_inventory:SetMaxWeight(playerId, Config.DefaultMaxWeight)
    TriggerClientEvent('xrb-backpack:forceCheck', playerId, true)
end

RegisterNetEvent('xrb-backpack:updateBagWeight', function(drawableId)
    applyPlayerWeight(source, drawableId)
end)

RegisterNetEvent('xrb-backpack:requestSync', function()
    resetPlayerWeight(source)
end)

local function onPlayerReady(playerId)
    CreateThread(function()
        Wait(1000)
        resetPlayerWeight(playerId)
    end)
end

AddEventHandler('esx:playerLoaded', function(playerId)
    onPlayerReady(playerId)
end)

AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
    onPlayerReady(source)
end)

AddEventHandler('Qbox:Server:PlayerLoaded', function(sourceId)
    onPlayerReady(sourceId or source)
end)

AddEventHandler('Qbox:playerLoaded', function(sourceId)
    onPlayerReady(sourceId or source)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= RESOURCE_NAME then
        return
    end

    CreateThread(function()
        Wait(1500)

        for _, playerId in ipairs(GetPlayers()) do
            resetPlayerWeight(tonumber(playerId))
        end
    end)
end)
