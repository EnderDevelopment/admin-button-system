local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 38) then -- E key
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                local targetPlayerId = GetPlayerServerId(closestPlayer)
                OpenAdminMenu(targetPlayerId)
            end
        end
    end
end)

function OpenAdminMenu(targetPlayerId)
    local elements = {}

    for _, button in ipairs(Config.AdminButtons) do
        table.insert(elements, {
            label = button.label,
            icon = button.icon,
            color = button.color,
            value = button.action
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu', {
        title = 'Admin Menu',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        TriggerServerEvent('adminButtonSystem:performAction', targetPlayerId, data.current.value)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end