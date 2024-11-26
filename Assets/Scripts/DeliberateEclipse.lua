function onLoad()
    Doors = getObjectFromGUID('a87629')

    resetButtons()
end

function resetButtons()
    self.createButton({
        click_function = 'closeDoors',
        function_owner = self,
        label          = 'Close Doors',
        position       = {0, 1, 1.34},
        width          = 450,
        height         = 50,
        font_size      = 75,
        color          = {0.3, 0.3, 0.3},
        font_color     = {1, 1, 1},
    })
end

function closeDoors(obj, color, alt_click)
    local doors = {'d713df', '2ca201'}

    for _, doorID in ipairs(doors) do
        Doors.call('doorController', {command = false, door = doorID})
    end

    self.clearButtons()
    --Wait.time(resetButtons, 20)
end