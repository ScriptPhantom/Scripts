if game.PlaceId == 6403373529 then
    local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
    if teleportFunc then
        teleportFunc([[
            -- script code here
        ]])
    end

    -- rest of your script code here

    -- add the function to start working again
    local function startAgain()
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        repeat task.wait() until game.Players.LocalPlayer
        wait(0.25)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Giangplay/Slap_Battles/main/File/Farm%20Bob.lua"))()
    end

    -- call the function to start working again
    startAgain()
end
