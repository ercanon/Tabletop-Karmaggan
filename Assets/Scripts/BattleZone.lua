function onLoad()
    self.createButton({
        click_function = 'checkWinner',
        function_owner = self,
        label          = 'Flip',
        position       = {0, 0.1, 0.65},
        width          = 400,
        height         = 50,
        font_size      = 75,
        color          = {0.8, 0, 0},
        font_color     = {1, 1, 1},
    })
end

function checkWinner()
    local coinFirst = setCastObject({1.26, 0.1, -0.52})
    local coinSecond = setCastObject({-1.28, 0.1, -0.52})
    if not coinFirst.hasTag('Coin') or not coinSecond.hasTag("Coin") then
        broadcastToAll('The 3 Blood Coins are not set in the Battle Zone', {1,1,1})
        broadcastToAll('Las 3 Fichas de Sangre no estan colocadas en la Zona de Batalla', {1,1,1})
        return
    end

    local cardFirst = setCastObject({0.533, 0, -0.2})
    local cardSecond = setCastObject({-0.533, 0, -0.2})
    if not cardFirst.hasTag('Object') or not cardSecond.hasTag('Object') then
        broadcastToAll('Cards are not set in the Battle Zone', {1,1,1})
        broadcastToAll('Las cartas no estan colocadas en la Zona de Batalla', {1,1,1})
        return
    end

    cardFirst.clearButtons()
    cardSecond.clearButtons()
    cardFirst.flip()
    cardSecond.flip()

    local result = checkType(cardFirst) - checkType(cardSecond)
    if result == 2 or result == -2 then 
        result = 0 
    end

    if result > 0 then 
        broadcastToAll('Left player wins', {1,1,1})
        broadcastToAll('El jugador de la izquierda gana', {1,1,1})
        if coinSecond.takeObject({position = coinFirst.getPosition(),}) == nil then
            coinSecond.setPositionSmooth(coinFirst.getPosition()) end
    elseif result < 0 then
        broadcastToAll('Right player wins', {1,1,1})
        broadcastToAll('El jugador de la derecha gana', {1,1,1})
        if coinFirst.takeObject({position = coinSecond.getPosition(),}) == nil then
            coinFirst.setPositionSmooth(coinSecond.getPosition()) end
    else 
        broadcastToAll('Tie', {1,1,1})
        broadcastToAll('Empate', {1,1,1}) end
end

function checkType(card)
    if card.hasTag('Attack') then return 0
    elseif card.hasTag('Nothing') then return -1
    elseif card.hasTag('Counter') then return 1
    elseif card.hasTag('Power') then return 5
    end
end

function setCastObject(pos)
    local object = Physics.cast({
        origin       = self.positionToWorld(pos),
        direction    = {0,1,0},
        max_distance = 1,
        })[1]

    if object ~= nil then return object.hit_object end
    return self
end