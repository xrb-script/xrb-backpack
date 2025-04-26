local currentBag = nil

-- Funksioni për kontrollin e qantës
local function CheckBackpack()
    local playerPed = PlayerPedId()
    if DoesEntityExist(playerPed) then
        local currentDrawable = GetPedDrawableVariation(playerPed, 5)
        if currentDrawable ~= currentBag then
            currentBag = currentDrawable
            TriggerServerEvent('backpack_weight:update', currentDrawable)
        end
    end
end

-- Kontrolli automatik çdo 1 sekonda
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        CheckBackpack()
    end
end)

-- Kontrolli pas spawnit (ESX/QBCore)
if Config.Framework == 'esx' then
    -- Për ESX
    RegisterNetEvent('esx:onPlayerSpawn')
    AddEventHandler('esx:onPlayerSpawn', function()
        Citizen.Wait(5000)
        CheckBackpack()
    end)
elseif Config.Framework == 'qbcore' then
    -- Për QBCore
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        Citizen.Wait(5000)
        CheckBackpack()
    end)
end