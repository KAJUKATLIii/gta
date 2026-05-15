fx_version 'cerulean'
game 'gta5'

name 'qbox-hud-selector'
author 'codex'
description 'Qbox HUD + speedometer selector with 20 styles each'
version '1.0.0'

lua54 'yes'

shared_script 'config.lua'

client_scripts {
    'client/main.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css',
    'web/app.js'
}
