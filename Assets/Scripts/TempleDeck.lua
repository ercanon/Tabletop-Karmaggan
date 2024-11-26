function onLoad()
    Doors = getObjectFromGUID('a87629')
    itemDeck = getObjectFromGUID('b355b1')
    prevCard = nil

    local item = self.getObjects()[1]
    if item ~= nil then
        item.shuffle() end

    item = itemDeck.getObjects()[1]
    if item ~= nil then
        item.shuffle() end


end

function onObjectLeaveContainer(container, object)
    local containerObj = self.getObjects()[1]

    if containerObj == nil or container.getGUID() ~= containerObj.getGUID() then
        return end

    if object.hasTag('Temple') and object.getGUID() ~= prevCard then
        prevCard = object.getGUID() 

        local dir = object.hasTag('CCW') and -1 or (object.hasTag('CW') and 1 or 0)

        local ringsInfo = {
            {'External', 'f71cd8'},
            {'Middle', '9adc7b'},
            {'Inner', '04c953'},
            {'Central', '035c97'},
        }

        for _, rInfo in ipairs(ringsInfo) do
            if object.hasTag(rInfo[1]) then
                Global.call('rotateRing', {ring = rInfo[2], direction = dir})
                break
            end
        end

        local doorsInfo = {
            {'SunOpen', 'd713df', true},
            {'SunClosed', 'd713df', false},
            {'MoonOpen', '2ca201', true},
            {'MoonClosed', '2ca201', false}
        }

        for _, dInfo in ipairs(doorsInfo) do
            if object.hasTag(dInfo[1]) then
                Doors.call('doorController', {command = dInfo[3], door = dInfo[2]})
                break
            end
        end
    end
end