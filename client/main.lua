local currentHudStyle = Config.DefaultHudStyle
local currentSpeedometerStyle = Config.DefaultSpeedometerStyle
local uiOpen = false

local placements = {
    hud = { x = Config.DefaultHudPlacement.x, y = Config.DefaultHudPlacement.y },
    speedometer = { x = Config.DefaultSpeedometerPlacement.x, y = Config.DefaultSpeedometerPlacement.y }
}

local function loadPlacements()
    local hudRaw = GetResourceKvpString('qbox_hud_placement')
    if hudRaw then
        local decoded = json.decode(hudRaw)
        if decoded and tonumber(decoded.x) and tonumber(decoded.y) then
            placements.hud.x = tonumber(decoded.x)
            placements.hud.y = tonumber(decoded.y)
        end
    end

    local speedoRaw = GetResourceKvpString('qbox_speedometer_placement')
    if speedoRaw then
        local decoded = json.decode(speedoRaw)
        if decoded and tonumber(decoded.x) and tonumber(decoded.y) then
            placements.speedometer.x = tonumber(decoded.x)
            placements.speedometer.y = tonumber(decoded.y)
        end
    end
end

local function savePlacements()
    SetResourceKvp('qbox_hud_placement', json.encode(placements.hud))
    SetResourceKvp('qbox_speedometer_placement', json.encode(placements.speedometer))
end

local function sendState(show)
    SendNUIMessage({
        action = show and 'open' or 'close',
        data = {
            hudStyles = Config.HudStyles,
            speedometerStyles = Config.SpeedometerStyles,
            hudStyle = currentHudStyle,
            speedometerStyle = currentSpeedometerStyle,
            placements = placements
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

RegisterNUICallback('savePlacement', function(data, cb)
    local element = data.element
    local x = tonumber(data.x)
    local y = tonumber(data.y)

    if (element == 'hud' or element == 'speedometer') and x and y then
        placements[element].x = math.min(math.max(x, 0.0), 1.0)
        placements[element].y = math.min(math.max(y, 0.0), 1.0)
        savePlacements()

        TriggerEvent('chat:addMessage', {
            color = { 251, 191, 36 },
            multiline = false,
            args = { 'PLACEMENT', ('Saved %s position: %.3f, %.3f'):format(element, placements[element].x, placements[element].y) }
        })
    end

    cb({ ok = true, placements = placements })
end)

RegisterNUICallback('resetPlacements', function(_, cb)
    placements.hud = { x = Config.DefaultHudPlacement.x, y = Config.DefaultHudPlacement.y }
    placements.speedometer = { x = Config.DefaultSpeedometerPlacement.x, y = Config.DefaultSpeedometerPlacement.y }
    savePlacements()
    cb({ ok = true, placements = placements })
end)

CreateThread(function()
    Wait(500)
    loadPlacements()
    sendState(false)
end)
