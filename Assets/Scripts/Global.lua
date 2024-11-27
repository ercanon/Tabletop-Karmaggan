function onLoad()
    numDice = -1
    rotCue = {}    
end

function rotateRing(ringParams)
    table.insert(rotCue, ringParams) 
    broadcastToAll('Roll the Temple Dice (Black Dice)', {1,1,1})
    broadcastToAll('Lanza el Dado de Templo (Dado Negro)', {1,1,1})

    Wait.condition(
    function ()
        local colList = 0
        local rotRing = getObjectFromGUID(ringParams.ring)
        sendMessage(ringParams.ring, ringParams.direction)
    
        for _, point in ipairs(rotRing.getSnapPoints()) do
            for _, object in ipairs(
            Physics.cast({
                origin       = rotRing.positionToWorld(point.position),
                direction    = {0,1,0},
                max_distance = 6})) 
            do
                if object.hit_object.hasTag('Collider') then
                    colList = colList + 1
                    rotRing.addAttachment(object.hit_object)
                end
            end
        end

        rotRing.setRotationSmooth({0, rotRing.getRotation().y + 22.5 * numDice * ringParams.direction, 0}, false, false)

        Wait.condition(
        function()
             for i = 1, colList do
                rotRing.removeAttachment(1)
            end
            numDice = -1
            table.remove(rotCue, 1)
        end,
        function() return rotRing.getRotationSmooth() == nil end
        )
    end,
    
    function() return numDice ~= -1 end,
    15, -- seconds timeout
    function()
        broadcastToAll('Took too long to throw the Temple Dice.', {1,0,0})
        broadcastToAll('Tardaste mucho en lanzar el Dado del Templo.', {1,0,0})
        table.remove(rotCue, 1)
    end
    )
end

function sendMessage(ring, direction)
    local ringNames = {
        ['035c97'] = {'Central Ring rotates ', 'Aro Central rota '},
        ['04c953'] = {'Inner Ring rotates ', 'Aro Interior rota '},
        ['9adc7b'] = {'Middle Ring rotates ', 'Aro Medio rota '},
        ['f71cd8'] = {'External Ring rotates ', 'Aro Exterior rota '}
    }

    local directionNames = {
        [1] = {'Clockwise ', 'Horario '},
        [-1] = {'CounterClockwise ', 'AntiHorario '},
    }

    local ringName = ringNames[ring] or {'Unknown Ring rotates ', 'Aro Desconocido rota '}
    local directionName = directionNames[direction] or {'Unknown ', 'Desconocido '}

    local e = ringName[1] .. directionName[1] .. numDice .. ' sector/s'
    local s = ringName[2] .. directionName[2] .. numDice .. ' sector/es'

    broadcastToAll(e, {1,1,1})
    broadcastToAll(s, {1,1,1})
end

function setDice(size)
    numDice = size
    Wait.time(function() numDice = -1 end, 3)
end