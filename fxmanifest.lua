fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'xrb-script'
description 'Universal Backpack Weight for ESX, QBCore, Qbox #xrb-script #xResul Albania'
version '2.0.0'

shared_scripts {
    '@xrb-lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'xrb-lib',
    'ox_inventory',
}
