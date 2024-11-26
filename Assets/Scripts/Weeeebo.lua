function onLoad(script_state)
    midGame = JSON.decode(script_state).mid

    lRoller = getObjectFromGUID('e0d0fc')
    lRoller.interactable = false
    rRoller = getObjectFromGUID('c70c93')
    rRoller.interactable = false

    if not midGame then
        lRoller.setPosition({-16.90, 0, -16.90})
        rRoller.setPosition({16.90, 0, 16.90})
    end
end

function onSave()
    return JSON.encode({mid = midGame})
end

function onFixedUpdate()
    if midGame then
        --lRoller.setRotation({lRoller.getRotation().x - 5, 135, 0})
        --rRoller.setRotation({rRoller.getRotation().x + 5, 315, 0})
    end
end

function onDrop(colorPlayer)
    local listBelow = Physics.cast({
        origin       = self.getPosition(),
        direction    = {0,-1,0},
        max_distance = 5.5
    })

    if not midGame then
        for _, obj in ipairs(listBelow) do
            if listBelow[1].hit_object.hasTag('Player') and obj.hit_object.getGUID() == '035c97' then
                midGame = true
                lRoller.setPositionSmooth({-16.9, 3, -16.9}, false)
                rRoller.setPositionSmooth({ 16.9, 3,  16.9}, false)
                break;
            end
        end
    end
end