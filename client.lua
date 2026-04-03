local RESOURCE_NAME = GetCurrentResourceName()
local currentBag = -1

local function getCurrentBagDrawable()
    local playerPed = PlayerPedId()

    if playerPed == 0 or not DoesEntityExist(playerPed) then
        return nil
    end

    return GetPedDrawableVariation(playerPed, 5)
end

local function syncBackpack(force)
    local drawable = getCurrentBagDrawable()
    if drawable == nil then
        return
    end

    if force then
        currentBag = -1
    end

    if drawable ~= currentBag then
        currentBag = drawable
        TriggerServerEvent('xrb-backpack:updateBagWeight', drawable)
    end
end

local function delayedSync(force)
    CreateThread(function()
        Wait(Config.InitialCheckDelay or 2000)
        syncBackpack(force)
    end)
end

CreateThread(function()
    Wait(3000)
    TriggerServerEvent('xrb-backpack:requestSync')

    while true do
        Wait(1000)
        syncBackpack(false)
    end
end)

RegisterNetEvent('xrb-backpack:forceCheck', function(force)
    delayedSync(force == true)
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= RESOURCE_NAME then
        return
    end

    delayedSync(true)
end)

RegisterNetEvent('esx:onPlayerSpawn', function()
    delayedSync(true)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    delayedSync(true)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    currentBag = -1
end)

RegisterNetEvent('Qbox:Client:PlayerLoaded', function()
    delayedSync(true)
end)

RegisterNetEvent('Qbox:Client:OnPlayerLoaded', function()
    delayedSync(true)
end)
