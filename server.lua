RegisterNetEvent('backpack_weight:update', function(drawableId)
    local src = source
    local playerWeight = Config.DefaultMaxWeight

    for _, bag in ipairs(Config.BagTypes) do
        if bag.drawable == drawableId then
            playerWeight = Config.DefaultMaxWeight + (bag.weight * 1000)
            break
        end
    end

    exports.ox_inventory:SetMaxWeight(src, playerWeight)
end)

-- Reset peshën kur lojtari lidhet (ESX/QBCore)
if Config.Framework == 'esx' then
    -- Për ESX
    AddEventHandler('esx:playerLoaded', function(playerId)
        exports.ox_inventory:SetMaxWeight(playerId, Config.DefaultMaxWeight)
    end)
elseif Config.Framework == 'qbcore' then
    -- Për QBCore
    AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
        local src = source
        exports.ox_inventory:SetMaxWeight(src, Config.DefaultMaxWeight)
    end)
end