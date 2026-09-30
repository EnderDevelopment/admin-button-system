Config = {}

-- Admin button settings
Config.AdminButtons = {
    {
        name = 'revive',
        label = 'Revive Player',
        icon = 'fa-solid fa-heart',
        color = 'green',
        action = 'revive'
    },
    {
        name = 'kick',
        label = 'Kick Player',
        icon = 'fa-solid fa-door-open',
        color = 'red',
        action = 'kick'
    },
    {
        name = 'ban',
        label = 'Ban Player',
        icon = 'fa-solid fa-ban',
        color = 'red',
        action = 'ban'
    }
}

-- Database settings
Config.Database = {
    tableName = 'admin_buttons'
}