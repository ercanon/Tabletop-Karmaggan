function onLoad(script_state)
    midGame = JSON.decode(script_state).mid

    lRoller = getObjectFromGUID('e0d0fc')
    lRoller.interactable = false
    rRoller = getObjectFromGUID('c70c93')
    rRoller.interactable = false
    rotValue = 0
end

function onSave()
    return JSON.encode({mid = midGame})
end

function onFixedUpdate()
    if midGame then
        rotValue = rotValue + 1 % 360
        lRoller.setRotation({rotValue, 135, 0})
        rRoller.setRotation({rotValue, 315, 0})
    end
end

function onPickUp(colPlayer)
    self.setRotation({0, 0, 0})
end

function onDrop(colorPlayer)
    local listBelow = Physics.cast({
        origin       = self.getPosition(),
        direction    = {0,-1,0},
        max_distance = 6
    })

    if listBelow[1].hit_object.hasTag('Player') then
        if not midGame then
            for _, obj in ipairs(listBelow) do
                if obj.hit_object.getGUID() == '04c953' then
                    broadcastToAll('El Huevo ha sido perturbado', {0.33,0.2,1})
                    broadcastToAll('The Egg has been disturbed', {0.33,0.2,1})
                    midGame = true
                    lRoller.setPositionSmooth({-16.9, 3, -16.9}, false)
                    rRoller.setPositionSmooth({ 16.9, 3,  16.9}, false)

                    Lighting.light_intensity = 1.5
                    Lighting.ambient_intensity = 2
                    Lighting.lut_contribution = 0.8
                    Lighting.setLightColor({r = 0.33, g = 0.2, b = 1})
                    Lighting.lut_index = 45 --Truly 46
                    break;
                end
            end
        end
    end
end