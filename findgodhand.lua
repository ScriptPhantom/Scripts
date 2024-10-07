if game.PlaceId == 6403373529 then
    local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
    if teleportFunc then
        teleportFunc([[ 
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        repeat task.wait() until game.Players.LocalPlayer
        wait(0.25)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ScriptPhantom/Scripts/refs/heads/main/findgodhand.lua"))()
        ]])
    end
end
local function checkGloveForGod()
    local foundGod = false
    -- Проходим по всем игрокам
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local gloveValue = leaderstats:FindFirstChild("Glove")
            -- Проверяем, если Glove существует и содержит "God"
            if gloveValue and string.match(gloveValue.Value, "God") then
                foundGod = true
                break
            end
        end
    end
    return foundGod
end

local function teleportToAvailableServer()
    local serverList = {}
    
    -- Получаем список серверов
    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
        -- Проверяем, если сервер не заполнен
        if v.playing and type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
            serverList[#serverList + 1] = v.id
        end
    end
    
    -- Если есть свободные сервера, телепортируемся
    if #serverList > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)])
    else
        warn("No available servers found for teleportation.")
    end
end

-- Если ни у кого нет Glove с "God", продолжаем телепортироваться, пока не телепортируемся успешно
while not checkGloveForGod() do
    teleportToAvailableServer()
    wait(5) -- Ждем 5 секунд перед следующей попыткой (можно изменить по необходимости)
end

-- Если "God" найдено хотя бы у одного игрока, выводим сообщение
print('НАШЕЛ БОГА!')
