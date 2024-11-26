function onLoad(script_state)
    local objects = self.getObjects()

    if #objects >= 9 then
        local positions = setTrans()
        for _, item in ipairs(objects) do
            local rand = math.random(#positions.pos)

            self.takeObject({
                position = positions.pos[rand],
                rotation = positions.rot[rand],
            })

            table.remove(positions.pos, rand)
            table.remove(positions.rot, rand)
        end
    end
end

function setTrans()
    return {
        pos = {
            {-22.68, 1.36, 1.11},
            {-1.11,  1.36, -22.69},
            {16.84,  1.36, -18.69},
            {22.69,  1.36, -1.12},
            {1.12,   1.36, 22.68},
            {-16.94, 1.36, 18.7},
            {-16.26, 2.36, -1.6},
            {-15.63, 2.36, -4.74},
            {4.72,   2.36, 15.62},
        },

        rot = {
            {0, 272.81, 0},
            {0, 182.81, 0},
            {0, 137.81, 0},
            {0, 92.81,  0},
            {0, 2.81,   0},
            {0, 317.81, 0},
            {0, 264.37, 0},
            {0, 253.12, 0},
            {0, 16.88,  0},
        }
    }
end