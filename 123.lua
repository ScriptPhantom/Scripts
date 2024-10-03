if game.PlaceId == 6403373529 then
    local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
    if teleportFunc then
        teleportFunc([[
if not game:IsLoaded() then
    game.Loaded:Wait()
end
repeat task.wait() until game.Players.LocalPlayer
wait(0.25)
loadstring(game:HttpGet("https://raw.githubusercontent.com/ScriptPhantom/Scripts/refs/heads/main/123.lua"))()
        ]])
    end

    -- rest of your script code here

    -- function to search for players with "god hand" or "god" in their part name
    local function searchForGodHand()
        local players = game.Players:GetPlayers()
        local found = false

        for _, player in pairs(players) do
            local character = player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name:lower():find("god hand") or part.Name:lower():find("god") then
                        found = true
                        break
                    end
                end
            end
            if found then break end
        end

        if not found then
            -- teleport to another server if no player with "god hand" or "god" is found
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
        end
    end

    -- call the function to search for players
    searchForGodHand()
end
