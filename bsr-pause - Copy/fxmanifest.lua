fx_version 'cerulean'
game 'gta5'


lua54 'yes'

shared_scripts {
    'bsr-config/bsr-config.lua',
}

client_scripts {
    'bsr-build/bsr-build-c.lua',
    'bsr-config/bsr-build-c.lua',
}

server_scripts {
    'bsr-build/bsr-build-s.lua',
}

ui_page 'bsr-nui/bsr-index.html'

files { 
    'bsr-nui/*',
    'bsr-nui/bsr-assets/*', 
}
