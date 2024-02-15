-- Framework Initialization
local Framework, Callback

if bsr_config.framework == 'QB' then
    Framework = exports[bsr_config.QB]:GetCoreObject()
    Callback = Framework.Functions.TriggerCallback
elseif bsr_config.framework == 'ESX' then
    Framework = exports[bsr_config.ESX]:getSharedObject()
    Callback = Framework.TriggerServerCallback
end

-- Disable native FiveM pause menu
CreateThread(function()
    while true do
        Wait(1)
        SetPauseMenuActive(false)
    end
end)

-- Function to Show Pause Menu
function bsr_pausemenu_show()
    if not Framework then
        print('Error: Framework is not initialized!')
        return
    end

    local p = promise.new()
    Callback('bsr-pausemenu:GetData', function(cb) p:resolve(cb) end)

    local zrData = Citizen.Await(p)

    SendNUIMessage({
        type = 'show',
        config = bsr_config,
        jobs = zrData.bsr_jobs,
        data = zrData.bsr_data
    })
    SetNuiFocus(true, true)
    StartScreenEffect(bsr_config.bsr_blur, 0, true)
end

-- Function to Hide Pause Menu
function bsr_pausemenu_hide()
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'hide'})
    StopScreenEffect(bsr_config.bsr_blur)
end

-- Register NUI Callback to Show Maps
RegisterNUICallback('show-maps', function()
    bsr_pausemenu_hide()
    TriggerScreenblurFadeOut(1000)
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 1, -1)

    if ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 1, -1) then
        bsr_pausemenu_hide()
    end
end)

-- Register NUI Callback to Show Settings
RegisterNUICallback('show-settings', function()
    bsr_pausemenu_hide()
    TriggerScreenblurFadeOut(1000)
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 0, -1)

    if ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 0, -1) then
        bsr_pausemenu_hide()
    end
end)

-- Register NUI Callback to Hide Pause Menu
RegisterNUICallback('hide', bsr_pausemenu_hide)

-- Register NUI Callback to Disconnect
RegisterNUICallback('disconnect', function()
    TriggerServerEvent("bsr-pausemenu:Disconnect")
end)