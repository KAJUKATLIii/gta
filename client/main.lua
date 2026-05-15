local currentHudStyle = Config.DefaultHudStyle
local currentSpeedometerStyle = Config.DefaultSpeedometerStyle
local uiOpen = false

local function sendState(show)
    SendNUIMessage({
        action = show and 'open' or 'close',
        data = {
            hudStyles = Config.HudStyles,
            speedometerStyles = Config.SpeedometerStyles,
            hudStyle = currentHudStyle,
            speedometerStyle = currentSpeedometerStyle
        }
    })
end

local function setHudStyle(styleId)
    currentHudStyle = styleId
    TriggerEvent('chat:addMessage', {
        color = { 59, 130, 246 },
        multiline = false,
        args = { 'HUD', ('Selected HUD style #%s'):format(styleId) }
    })
end

local function setSpeedometerStyle(styleId)
    currentSpeedometerStyle = styleId
    TriggerEvent('chat:addMessage', {
        color = { 34, 197, 94 },
        multiline = false,
        args = { 'SPEEDOMETER', ('Selected style #%s'):format(styleId) }
    })
end

local function openUi()
    if uiOpen then return end

    uiOpen = true
    SetNuiFocus(true, true)
    sendState(true)
end

local function closeUi()
    if not uiOpen then return end

    uiOpen = false
    SetNuiFocus(false, false)
    sendState(false)
end

RegisterCommand(Config.OpenCommand, function()
    openUi()
end, false)

RegisterKeyMapping(Config.OpenCommand, 'Open HUD & Speedometer selector', 'keyboard', 'F10')

RegisterNUICallback('close', function(_, cb)
    closeUi()
    cb({ ok = true })
end)

RegisterNUICallback('selectHudStyle', function(data, cb)
    local styleId = tonumber(data.styleId)
    if styleId and Config.HudStyles[styleId] then
        setHudStyle(styleId)
    end
    cb({ ok = true })
end)

RegisterNUICallback('selectSpeedometerStyle', function(data, cb)
    local styleId = tonumber(data.styleId)
    if styleId and Config.SpeedometerStyles[styleId] then
        setSpeedometerStyle(styleId)
    end
    cb({ ok = true })
end)

CreateThread(function()
    -- Push defaults once resource starts
    Wait(500)
    sendState(false)
end)
