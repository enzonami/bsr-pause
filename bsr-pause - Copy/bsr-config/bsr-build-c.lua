-- Section 1: Initialization and Variable Declaration
local bsr_menu_enabled = true

-- Section 2: Key Mapping and Command Registration
RegisterKeyMapping("bsr-pausemenu:show", "Toggle Pause Menu", "keyboard", "ESCAPE")

RegisterCommand('bsr-pausemenu:show', function()
    -- Section 3: Conditions to Show Pause Menu
    if not IsPauseMenuActive() and not IsNuiFocused() and not IsEntityDead(PlayerPedId()) then
        if bsr_menu_enabled then
            bsr_pausemenu_show()
        end
    end
end, false)

-- Section 4: Function to Hide the Pause Menu
function bsr_pausemenu_hide()
    StopScreenEffect(bsr_config.bsr_blur)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "hide",
        toggle = false
    })
end

-- Section 5: Event Handlers
RegisterNetEvent('bsr-pausemenu:hide')
AddEventHandler('bsr-pausemenu:hide', bsr_pausemenu_hide)

RegisterNetEvent('bsr-pausemenu:disable')
AddEventHandler('bsr-pausemenu:disable', function()
    bsr_menu_enabled = false
    bsr_pausemenu_hide() -- Hide the menu if it's currently open when disabled
end)

RegisterNetEvent('bsr-pausemenu:enable')
AddEventHandler('bsr-pausemenu:enable', function()
    bsr_menu_enabled = true
end)

-- Section 6: Logout Function
function bsr_call_logout()
    TriggerEvent('bsr-multicharacter:start')
end