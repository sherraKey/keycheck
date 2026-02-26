-- ================= WINGS LOGIC (UPDATED) =================
local wingsRunning = false

local function unlockWings()
    wingsRunning = true
    WingsButton.Text = "Loading..."
    WingsButton.BackgroundColor3 = Color3.fromRGB(100,100,100)
    WingsButton.Active = false
    WingsStatus.Text = "Scanning bag..."
    task.spawn(function()
        local bag = Player:FindFirstChild("Bag")
        if not bag then
            WingsStatus.Text = "Bag folder not found!"
            wingsRunning = false
            WingsButton.Text = "Unlock Exclusive Wings"
            WingsButton.BackgroundColor3 = Color3.fromRGB(150,0,150)
            WingsButton.Active = true
            return
        end
        
        local ids = {}
        for _, child in ipairs(bag:GetChildren()) do
            local name = child.Name
            if type(name)=="string" and name:match("^13000%d+$") then
                local id = tonumber(name)
                if id and child:IsA("NumberValue") then
                    -- Only add if value is 0 (skip if value is 1)
                    if child.Value == 0 then
                        table.insert(ids, id)
                    end
                end
            end
        end
        
        if #ids == 0 then
            WingsStatus.Text = "No exclusive wings found in bag."
            wingsRunning = false
            WingsButton.Text = "Unlock Exclusive Wings"
            WingsButton.BackgroundColor3 = Color3.fromRGB(150,0,150)
            WingsButton.Active = true
            return
        end
        
        table.sort(ids)
        -- Hide ID range; show only "Unlocking..."
        WingsStatus.Text = "Unlocking..."
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("Msg"):WaitForChild("RemoteEvent")
        
        -- Loop through each collected ID (only those with value 0)
        for _, id in ipairs(ids) do
            if not wingsRunning then break end
            remote:FireServer("BuyWing", id)
            wait(0.1)
        end
        
        WingsStatus.Text = "Unlock process completed!"
        wingsRunning = false
        WingsButton.Text = "Unlock Exclusive Wings"
        WingsButton.BackgroundColor3 = Color3.fromRGB(150,0,150)
        WingsButton.Active = true
    end)
end

WingsButton.MouseButton1Click:Connect(function()
    if not isFullAuthorized then showUnauthorizedPopup(); return end
    if not wingsRunning then unlockWings() end
end)