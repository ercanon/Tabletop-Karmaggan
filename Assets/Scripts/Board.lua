function onLoad()
    untouch()

    debugMode = false
    self.createButton({
        click_function = 'genRotControls',
        function_owner = self,
        position       = {2.15, -7, 0},
        rotation       = {0, -90, 90},
        width          = 3,
        height         = 1000,
        color          = {1, 0, 0},
        tooltip        = 'Ring Rotation Debug'
    })
end

function doorController(doorParams)
    Wait.time(
        function()
        local doorMessages = {
            ['d713df'] = {'Sun Doors', 'Puertas Solares'},
            ['2ca201'] = {'Moon Doors', 'Puertas Lunares'}
        }
        local e, s = doorMessages[doorParams.door] or {'Unknown Doors', 'Puertas Desconocidas'}

        if doorParams.command then
            getObjectFromGUID(doorParams.door).setPositionSmooth({0, -0.2, 0})
            e = e .. ' opens'
            s = s .. ' se abren'
        elseif not doorParams.command then
            getObjectFromGUID(doorParams.door).setPositionSmooth({0, 2.59, 0})
            e = e .. ' closes'
            s = s .. ' se cierran'
        end

        broadcastToAll(e, {1,1,1})
        broadcastToAll(s, {1,1,1})
    end, 3)
end

function untouch()
    local objects = {
        'a87629', '41e637', '2ca201', 'd713df', --Board
        'f02bcf', 'a677ed', 'be01a7', 'e84d1c', '08a236', '3a51cc', '725c06', '53f52c', '1cbf7d', '78f614' --BloodCoins
    }
    for _, guid in ipairs(objects) do
        getObjectFromGUID(guid).interactable = false
    end

    local ringAttachments = {
        { '035c97', '41e80c' }, --Central
        { '04c953', 'ed0254' }, --Inner
        { '9adc7b', '1fb4a4' }, --Middle
        { 'f71cd8', 'cc5c14' }  --External
    }
    for _, ringAttach in ipairs(ringAttachments) do
        getObjectFromGUID(ringAttach[1]).removeAttachments()
        getObjectFromGUID(ringAttach[1]).interactable = false
        getObjectFromGUID(ringAttach[1]).addAttachment(getObjectFromGUID(ringAttach[2]))
    end
end

function genRotControls(obj, color, alt_click)
    if debugMode then
        debugMode = false
        for i = 1, #self.getButtons() - 1 do
            self.removeButton(i)
        end
    else
        debugMode = true
        resetButtons(self)
    end
end

function resetButtons (obj)
    local settings = {
        { label = 'External',   color = {0.16, 0.78, 0.86}, pos = {-1.7, 1, -1},    ring = 'ext' },
        { label = 'Middle',     color = {0.59, 0.86, 0.2},  pos = {1.7, 1, -1},     ring = 'mid' },
        { label = 'Inner',      color = {0.98, 0.75, 0.078},pos = {-1.7, 1, 0.5},   ring = 'in' },
        { label = 'Central',    color = {0.78, 0.24, 0.94}, pos = {1.7, 1, 0.5},    ring = 'cen' }
    }
    for _, button in ipairs(settings) do
        obj.createButton({
            click_function = 'nill',
            function_owner = self,
            label          = button.label,
            position       = button.pos,
            width          = 0,
            height         = 0,
            font_size      = 150,
            color          = button.color,
            font_color     = {1, 1, 1},
        })

        obj.createButton({
            click_function = button.ring .. 'CW',
            function_owner = self,
            label          = string.char(8635),
            position       = {button.pos[1] - 0.35, button.pos[2], button.pos[3] + 0.5},
            width          = 250,
            height         = 200,
            font_size      = 150,
            color          = button.color,
            font_color     = {1, 1, 1},
            tooltip        = 'ClockWise / Horario',
        })

        obj.createButton({
            click_function = button.ring .. 'CCW',
            function_owner = self,
            label          = string.char(8634),
            position       = {button.pos[1] + 0.35, button.pos[2], button.pos[3] + 0.5},
            width          = 250,
            height         = 200,
            font_size      = 150,
            color          = button.color,
            font_color     = {1, 1, 1},
            tooltip        = 'CounterClockWise / AntiHorario',
        })
    end
end

function rotateRing(ring, direction)
    Global.call('rotateRing', {ring = ring, direction = direction})
end

-- CW/CCW ring button handlers
function extCW() rotateRing('f71cd8', 1) end
function extCCW() rotateRing('f71cd8', -1) end

function midCW() rotateRing('9adc7b', 1) end
function midCCW() rotateRing('9adc7b', -1) end

function inCW() rotateRing('04c953', 1) end
function inCCW() rotateRing('04c953', -1) end

function cenCW() rotateRing('035c97', 1) end
function cenCCW() rotateRing('035c97', -1) end