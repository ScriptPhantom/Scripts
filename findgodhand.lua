if game.PlaceId == 6403373529 then
    local teleportFunc = queueonteleport or queue_on_teleport or (syn and syn.queue_on_teleport)
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
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local gloveValue = leaderstats:FindFirstChild("Glove")
            if gloveValue and string.match(gloveValue.Value, "God") then
                return true
            end
        end
    end
    return false
end

local function teleportToAvailableServer()
    local serverList = {}
    local serversResponse = game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
    local servers = game:GetService("HttpService"):JSONDecode(serversResponse).data

    for _, server in ipairs(servers) do
        if server.playing and type(server) == "table" and server.maxPlayers > server.playing and server.playing >= 5 and server.playing <= 13 and server.id ~= game.JobId then
            table.insert(serverList, server.id)
        end
    end

    if #serverList > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)])
    end
end

-- Attempt to teleport if "God" glove is not found
for i = 1, 10 do
    if not checkGloveForGod() then
        print('Бога не найдено, телепортируемся на другой сервер... Попытка #' .. i)
        teleportToAvailableServer()
        wait(1) -- Wait 1 second before next attempt
    else
        print('НАШЕЛ БОГА!')
        break -- Exit loop if "God" is found
    end
end

-- If "God" is found, execute the specified script
if checkGloveForGod() then
    if not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2125950512) then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "[ Giang ]",
            Text = "📢 [ You have not issued Bob, and not badge bob ] 🇻🇳.",
            Icon = "rbxassetid://7733658504",
            Duration = 10
        })

        fireclickdetector(workspace.Lobby.Replica.ClickDetector)
        wait(0.25)
        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
        wait(0.4)

        if _G.SlappleFarm then
            if game.Players.LocalPlayer.Character:FindFirstChild("entered") then
                for _, slapple in ipairs(workspace.Arena.island5.Slapples:GetChildren()) do
                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and slapple:IsA("Model") and (slapple.Name == "Slapple" or slapple.Name == "GoldenSlapple") and slapple:FindFirstChild("Glove") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, slapple.Glove, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, slapple.Glove, 1)
                    end
                end
            end
        end

        if _G.CandyFarm then
            for _, candy in ipairs(game.Workspace.CandyCorns:GetChildren()) do
                if game.Players.LocalPlayer.Character:FindFirstChild("Head") and candy:FindFirstChildWhichIsA("TouchTransmitter") then
                    firetouchinterest(game.Players.LocalPlayer.Character.Head, candy, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.Head, candy, 1)
                end
            end
        end

        wait(0.4)
        -- Execute duplication
        game:GetService("ReplicatedStorage").Duplicate:FireServer(true)

        -- Attempt to teleport after duplication
        wait(0.4)
        teleportToAvailableServer()
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "[ Giang ]",
            Text = "📢 [ You Got Badge Bob, Meaning you already have Bob ] 🇻🇳.",
            Icon = "rbxassetid://7733658504",
            Duration = 10
        })
    end
end
