name = "BlockParty Helper"
description = "Totally a cheat but fuck it :D"


local blockColors = {
    blue = {0, 0, 255},
    red = {255, 0, 0},
    pink = {255, 105, 180},
    gray = {173, 216, 230},
    black = {173, 216, 230},
    green = {0, 255, 0},
    cyan = {0, 255, 255},
    magenta = {255, 0, 255},
    yellow = {255, 255, 0},
    brown = {139, 69, 19},
    light_blue = {173, 216, 230},
    light_gray = {173, 216, 230},
    orange = {255, 165, 0},
    purple = {128, 0, 128},
    white = {173, 216, 230},
    lime = {50, 205, 50}
}


local color = {255, 0, 0}
local waypoints = {}


function updateColorFromMessage(message)
    local colorMap = {
        ["§9Blue"] = "blue",
        ["§bLight Blue"] = "light_blue",
        ["§cRed"] = "red",
        ["§3Cyan"] = "cyan",
        ["§6Orange"] = "orange",
        ["§5Purple"] = "purple",
        ["§fWhite"] = "white",
        ["§aLime"] = "lime",
        ["§8Gray"] = "gray"
    }

    for key, value in pairs(colorMap) do
        if message:match(key) then return value end
    end


    if message:match("Pink") then return "pink" end
    if message:match("Black") then return "black" end
    if message:match("Green") then return "green" end
    if message:match("Magenta") then return "magenta" end
    if message:match("Yellow") then return "yellow" end
    if message:match("Brown") then return "brown" end
    if message:match("Light Gray") then return "light_gray" end

    return nil
end


event.listen("ChatMessageAdded", function(message, username, type, xuid)
    local newColor = updateColorFromMessage(message)
    if newColor then
        color = blockColors[newColor] or {255, 255, 255}
        local blocks = dimension.findBlock("hive:studio_floor_symbol_" .. newColor)
        waypoints = {}

        if blocks then
            for i = 1, #blocks do
                table.insert(waypoints, blocks[i])
            end
        end
        print("Changed color to " .. newColor .. " and updated waypoints")
    end
end)


function render3DCube(x, y, z, size)
    gfx.color(color[1], color[2], color[3])
    gfx.quad(x, y, z, x + size, y, z, x + size, y + size, z, x, y + size, z, true)
    gfx.quad(x, y, z + size, x + size, y, z + size, x + size, y + size, z + size, x, y + size, z + size, true)
    gfx.quad(x, y, z, x, y + size, z, x, y + size, z + size, x, y, z + size, true)
    gfx.quad(x + size, y, z, x + size, y + size, z, x + size, y + size, z + size, x + size, y, z + size, true)
    gfx.quad(x, y + size, z, x + size, y + size, z, x + size, y + size, z + size, x, y + size, z + size, true)
    gfx.quad(x, y, z, x + size, y, z, x + size, y, z + size, x, y, z + size, true)
end


function render3d()
    for i = 1, #waypoints do
        local x, y, z = table.unpack(waypoints[i])
        render3DCube(x, y, z, 1.15)
    end
end
