local userInputService = game:GetService("UserInputService")
local attach = true
local mode = 2
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

-- Menangkap input tombol E dan R untuk mengklik tombol yang sesuai
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.E then
            Normal:Activate() -- Menekan tombol "2"
            print("Tombol 2 ditekan melalui tombol E!")
        elseif input.KeyCode == Enum.KeyCode.R then
            Off:Activate() -- Menekan tombol "Off"
            print("Tombol Off ditekan melalui tombol R!")
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

        -- Menghitung jarak dari bola ke pemain
        for _, axis in ipairs({"X", "Y", "Z"}) do
            local diff = math.abs(ball.CFrame[axis] - playerPos[axis])
            pos = pos + diff
        end

        -- Logika mode
        if mode == 2 and pos < 50 then
            CLC()
        end

    elseif not (ball.Highlight.FillColor == RB) then
        attach = true
    end
end
