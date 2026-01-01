-- SAGO HUB V2 - Best Sagopa Kajmer Edition (2026 Optimized)
-- Bu script eğitim amaçlı, modern UI ve stabil fonksiyonlar üzerine kurulmuştur.

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "SAGO HUB V2",
    SubTitle = "Sagopa Kajmer Edition",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Sekmeler
local Tabs = {
    Main = Window:AddTab({ Title = "Karakter", Icon = "user" }),
    Emotes = Window:AddTab({ Title = "Danslar", Icon = "music" }),
    Teleport = Window:AddTab({ Title = "Işınlanma", Icon = "map-pin" }),
    Settings = Window:AddTab({ Title = "Ayarlar", Icon = "settings" })
}

-- [ KARAKTER AYARLARI ]
Tabs.Main:AddSlider("WalkSpeed", {
    Title = "Yürüme Hızı",
    Default = 16,
    Min = 16,
    Max = 250,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

Tabs.Main:AddSlider("JumpPower", {
    Title = "Zıplama Gücü",
    Default = 50,
    Min = 50,
    Max = 500,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

-- [ DANS / EMOTES ]
-- Not: Emote'ların her oyunda görünmesi için sunucu tarafında (Server-Side) sahiplik gerekir.
-- Bu liste animasyonları oynatmak için bir arayüz sağlar.
Tabs.Emotes:AddButton({
    Title = "Dans Et (Örnek)",
    Description = "Karakteri dans ettirir.",
    Callback = function()
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://507771019" -- Örnek dans ID
        local load = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
        load:Play()
        Fluent:Notify({ Title = "Sago Hub", Content = "Dans Başladı!", Duration = 3 })
    end
})

-- [ IŞINLANMA ]
local PlayerList = {}
for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
        table.insert(PlayerList, v.Name)
    end
end

local Dropdown = Tabs.Teleport:AddDropdown("PlayerDropdown", {
    Title = "Oyuncu Seç",
    Values = PlayerList,
    Multi = false,
    Default = nil,
})

Tabs.Teleport:AddButton({
    Title = "Işınlan",
    Callback = function()
        local targetName = Dropdown.Value
        local targetPlayer = game.Players:FindFirstChild(targetName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            hrp.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            hrp.AssemblyLinearVelocity = Vector3.new(0,0,0) -- Düşme hasarını önlemek için hızı sıfırla
        end
    end
})

-- Anti-AFK Özelliği
local VirtualUser = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    Fluent:Notify({ Title = "Sago Hub", Content = "Anti-AFK Aktif: Atılma Engellendi.", Duration = 5 })
end)

Window:SelectTab(1)
Fluent:Notify({
    Title = "SAGO HUB V2",
    Content = "Heval, panel başarıyla yüklendi. İyi eğlenceler! 💜",
    Duration = 5
})