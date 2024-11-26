function onRandomize(player)
    Wait.condition(
        function()
            Global.call('setDice', self.getRotationValue())
        end,
        function()
            return self.resting
        end
    )
end