local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('adminButtonSystem:performAction')
AddEventHandler('adminButtonSystem:performAction', function(targetPlayerId, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetPlayerId)

    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
        if action == 'revive' then
            TriggerClientEvent('esx_ambulancejob:revive', targetPlayerId)
            MySQL.Async.execute('INSERT INTO admin_buttons (player_id, button_name, action_time) VALUES (@player_id, @button_name, NOW())', {
                ['@player_id'] = targetPlayer.identifier,
                ['@button_name'] = 'revive'
            })
        elseif action == 'kick' then
            DropPlayer(targetPlayerId, 'You have been kicked by an admin.')
            MySQL.Async.execute('INSERT INTO admin_buttons (player_id, button_name, action_time) VALUES (@player_id, @button_name, NOW())', {
                ['@player_id'] = targetPlayer.identifier,
                ['@button_name'] = 'kick'
            })
        elseif action == 'ban' then
            MySQL.Async.execute('INSERT INTO bans (identifier, reason, banned_by, banned_on) VALUES (@identifier, @reason, @banned_by, NOW())', {
                ['@identifier'] = targetPlayer.identifier,
                ['@reason'] = 'Banned by admin',
                ['@banned_by'] = xPlayer.identifier
            })
            DropPlayer(targetPlayerId, 'You have been banned by an admin.')
            MySQL.Async.execute('INSERT INTO admin_buttons (player_id, button_name, action_time) VALUES (@player_id, @button_name, NOW())', {
                ['@player_id'] = targetPlayer.identifier,
                ['@button_name'] = 'ban'
            })
        end
    else
        print(('adminButtonSystem: %s attempted to perform admin action without permission'):format(xPlayer.identifier))
    end
end)