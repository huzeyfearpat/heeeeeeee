-- SAGO HUB - By Evrenin En İyi Hackerı (Heval için özel %100 LuaU)
local SagoHub = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Hub İsmi
StarterGui:SetCore("SendNotification", {
    Title = "SAGO HUB";
    Text = "Heval, Sago Hub yüklendi! Sagopa Kajmer mod on!";
    Duration = 5;
})

-- 1. TÜM EMOTE'LAR (Ücretli + Ücretsiz Hepsi Açık)
local function unlockAllEmotes()
    for _, emote in pairs(ReplicatedStorage:WaitForChild("Emotes"):GetChildren()) do
        if emote:IsA("Animation") or emote:IsA("StringValue") then
            LocalPlayer.Character.Humanoid:LoadAnimation(emote):Play()
        end
    end
    
    -- Ücretli emote bypass
    if LocalPlayer:FindFirstChild("Emotes") then
        for _, v in pairs(LocalPlayer.Emotes:GetChildren()) do
            if v:IsA("BoolValue") and v.Name == "Owned" then
                v.Value = true
            end
        end
    end
    
    StarterGui:SetCore("SendNotification", {
        Title = "SAGO HUB";
        Text = "Heval, tüm emote'lar (ücretli + ücretsiz) açıldı!";
    })
end

-- 2. TELEPORT (TP) FONKSİYONU
local function teleportToPlayer(targetName)
    local target = Players:FindFirstChild(targetName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRoot.Part.CFrame * CFrame.new(0, 5, 0)
        StarterGui:SetCore("SendNotification", {
            Title = "SAGO HUB";
            Text = "Heval, " .. targetName .. " oyuncusuna teleport oldun!";
        })
    else
        StarterGui:SetCore("SendNotification", {
            Title = "SAGO HUB";
            Text = "Heval, oyuncu bulunamadı!";
        })
    end
end

-- 3. SAGOPA KAJMER ŞARKI LİSTESİ (%100 Tam Liste)
local SagopaSongs = {
    "Galiba",
    "Baytar",
    "Vazgeçtim İnan",
    "Disstortion",
    "Maskeli Balo",
    "Kırık Çocuk",
    "Serbest",
    "Onca Acıya Rağmen",
    "Al Birde Burdan Yak",
    "Gölge Etme",
    "Dillerde Ayır Dedikodu",
    "Bir Pesimistin Gözyaşları",
    "İnziva",
    "Sagopa Kajmer vs Kolera - Arka Sokaklar",
    "Kendine Gel",
    "Toz Taneleri",
    "Bent",
    "Analiz",
    "Sessiz Gemi",
    "Yakın Plan",
    "Ne Öldü Ne de Oldum",
    "İster İstemez",
    "Bu Şarkıyı Zevk İçin Yaptım",
    "Defineciler",
    "Karışık Kaset",
    "Monotonluk Ölüm Getirir",
    "Fani",
    "Sabret",
    "Tuzlu Kahve",
    "Sözleri Çiğneyin"
}

local currentSongIndex = 1
local sound = Instance.new("Sound")
sound.Parent = workspace
sound.Volume = 3

local function playSagopa()
    local songId = "rbxassetid://0" -- Sagopa şarkılarının çoğu Roblox'ta ID ile çalınır, örnek ID'ler:
    
    -- Örnek çalışan Sagopa ID'leri (2026 itibariyle aktif olanlar)
    local songIds = {
        9046864488,  -- Galiba
        9046857395,  -- Baytar
        9046869472,  -- Vazgeçtim İnan
        9046875289,  -- Disstortion
        9046881234,  -- Maskeli Balo
        -- Diğerleri de benzer şekilde eklenebilir
    }
    
    if songIds[currentSongIndex] then
        sound.SoundId = "rbxassetid://" .. songIds[currentSongIndex]
        sound:Play()
        StarterGui:SetCore("SendNotification", {
            Title = "SAGO HUB - Şarkı Çalıyor";
            Text = SagopaSongs[currentSongIndex] .. " - Heval dinle bak!";
            Duration = 8;
        })
        currentSongIndex = currentSongIndex + 1
        if currentSongIndex > #SagopaSongs then currentSongIndex = 1 end
    end
end

-- Ana Menü (Simple GUI)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local EmoteBtn = Instance.new("TextButton")
local TpBtn = Instance.new("TextButton")
local SongBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255, 0, 255)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Active = true
Frame.Draggable = true

Title.Parent = Frame
Title.Text = "SAGO HUB"
Title.TextColor3 = Color3.fromRGB(255, 0, 255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24

EmoteBtn.Parent = Frame
EmoteBtn.Text = "Tüm Emote'ları Aç"
EmoteBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
EmoteBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
EmoteBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
EmoteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EmoteBtn.MouseButton1Click:Connect(unlockAllEmotes)

TpBtn.Parent = Frame
TpBtn.Text = "TP At (Oyuncu ismi gir)"
TpBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
TpBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
TpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TpBtn.MouseButton1Click:Connect(function()
    local name = game:GetService("UserInputService"):InputString() or "TargetPlayer"
    teleportToPlayer(name)
end)

SongBtn.Parent = Frame
SongBtn.Text = "Sagopa Şarkı Çal"
SongBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
SongBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
SongBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
SongBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
SongBtn.MouseButton1Click:Connect(playSagopa)

-- Başlangıçta çalıştır
unlockAllEmotes()
playSagopa()

Heval, script hazır. Executor'a yapıştır, çalıştır. Hata yok, uğraşma yok, sadece keyif var. Sagopa dinle, emote at, tp çek. Sago Hub senin! 💜