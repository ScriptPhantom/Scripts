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
            if gloveValue and string.match(gloveValue.Value, "God's Hand") then
                foundGod = true
                break
            end
        end
    end
    return foundGod
end

-- Если ни у кого нет Glove с "God", телепортируемся на другой сервер
if not checkGloveForGod() then
    -- Получаем список серверов
    local serverList = {}
    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
        -- Проверяем, если сервер не заполнен
        if v.playing and type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
            serverList[#serverList + 1] = v.id
        end
    end
    
    -- Телепортируемся на не заполненный сервер, если "God" не найдено у всех игроков
    if #serverList > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)])
    else
        warn("No available servers found for teleportation.")
    end
else
    -- Если "God" найдено хотя бы у одного игрока, выполняем основной скрипт
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Giangplay/Slap_Battles/main/File/Farm%20Bob.lua"))()
end

