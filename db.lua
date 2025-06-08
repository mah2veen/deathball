local userInputService = game:GetService("UserInputService")
local attach = true
local mode = 2 -- Default mode
local RB = Color3.new(1, 0, 0)

-- Fungsi untuk mengaktifkan mode
local function CLC()
    if attach then
        game:service("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
        attach = false
        prev = 0
        rad = 0
    end
end

-- Membuat GUI
local Gui = Instance.new("ScreenGui")
Gui.Parent = game.Players.LocalPlayer.PlayerGui

local Off = Instance.new("TextButton")
Off.Parent = Gui
Off.Size = UDim2.new(0, 50, 0, 50)
Off.Position = UDim2.new(1, -50, 0, 0)
Off.Text = "Off"

local Normal = Instance.new("TextButton")
Normal.Parent = Gui
Normal.Size = UDim2.new(0, 50, 0, 50)
Normal.Position = UDim2.new(1, -250, 0, 50)
Normal.Text = "2"

-- Event untuk tombol GUI
Off.Activated:Connect(function()
    mode = 0 -- Mode dimatikan
    print("Mode dinonaktifkan melalui tombol Off!")
end)

Normal.Activated:Connect(function()
    mode = 2 -- Mode diaktifkan
    print("Mode 2 diaktifkan!")
end)

-- Menangkap input tombol E dan R
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.E then
            Normal:Activate() -- Menekan tombol "2"
            print("Tombol 2 ditekan melalui tombol E!")
        elseif input.KeyCode == Enum.KeyCode.R then
            Off:Activate() -- Menekan tombol "Off"
            mode = 0 -- Pastikan mode direset saat tombol R ditekan
            print("Tombol Off ditekan melalui tombol R, mode dinonaktifkan!")
        end
    end
end)

-- Loop utama untuk eksekusi mode
while true do
    wait(0.05)
    local ball = game.Workspace:WaitForChild("Part")

    if ball.Highlight.FillColor == RB then
        local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local pos = 0

        for _, axis in ipairs({"X", "Y", "Z"}) do
            local diff = math.abs(ball.CFrame[axis] - playerPos[axis])
            pos = pos + diff
        end

        if mode == 2 and pos < 50 then
            CLC()
        end

    elseif not (ball.Highlight.FillColor == RB) then
        attach = true
    end
end

