-- KRNL Mix - Advanced Script Executor
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local localPlayer = Players.LocalPlayer

-- Основной GUI
local KMGui = Instance.new("ScreenGui")
KMGui.Name = "KRNLMix"
KMGui.Parent = CoreGui

-- Фон с анимированными полосками
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Size = UDim2.new(0, 700, 0, 500)
backgroundFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
backgroundFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
backgroundFrame.BorderSizePixel = 0
backgroundFrame.Parent = KMGui

-- Liquid Glass эффект
local glassEffect = Instance.new("Frame")
glassEffect.Size = UDim2.new(1, 0, 1, 0)
glassEffect.BackgroundColor3 = Color3.new(0.3, 0, 0)
glassEffect.BackgroundTransparency = 0.9
glassEffect.BorderSizePixel = 0
glassEffect.Parent = backgroundFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = backgroundFrame

-- Анимированные полоски
local stripes = {}
for i = 1, 25 do
    local stripe = Instance.new("Frame")
    stripe.Size = UDim2.new(0, 3, 1, 0)
    stripe.Position = UDim2.new(0, i * 35, 0, 0)
    stripe.BackgroundColor3 = Color3.new(1, 0.1, 0.1)
    stripe.BackgroundTransparency = 0.8
    stripe.BorderSizePixel = 0
    stripe.Rotation = math.random(-5, 5)
    stripe.Parent = backgroundFrame
    table.insert(stripes, stripe)
end

-- Плавающие частицы
local particles = {}
for i = 1, 15 do
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(5, 15), 0, math.random(5, 15))
    particle.Position = UDim2.new(0, math.random(0, 650), 0, math.random(0, 450))
    particle.BackgroundColor3 = Color3.new(1, 0.3, 0.3)
    particle.BackgroundTransparency = 0.9
    particle.BorderSizePixel = 0
    particle.Parent = backgroundFrame
    
    local particleCorner = Instance.new("UICorner")
    particleCorner.CornerRadius = UDim.new(1, 0)
    particleCorner.Parent = particle
    table.insert(particles, particle)
end

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.new(0.25, 0, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = backgroundFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "KRNL MIX"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.Parent = titleBar

-- Кнопки управления
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 35, 0, 35)
minimizeButton.Position = UDim2.new(1, -80, 0, 5)
minimizeButton.BackgroundColor3 = Color3.new(1, 0.6, 0)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18
minimizeButton.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.new(1, 0.2, 0.2)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.Parent = titleBar

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = minimizeButton
buttonCorner:Clone().Parent = closeButton

-- Вкладки
local tabsContainer = Instance.new("Frame")
tabsContainer.Size = UDim2.new(1, 0, 0, 40)
tabsContainer.Position = UDim2.new(0, 0, 0, 45)
tabsContainer.BackgroundTransparency = 1
tabsContainer.Parent = backgroundFrame

local tabs = {
    "Executor",
    "Settings", 
    "Premium"
}

local currentTab = "Executor"
local tabButtons = {}

for i, tabName in pairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 120, 0, 35)
    tabButton.Position = UDim2.new(0, (i-1) * 125, 0, 2)
    tabButton.BackgroundColor3 = Color3.new(0.2, 0, 0)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.Parent = tabsContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabButton
    
    tabButtons[tabName] = tabButton
end

-- Основное содержимое
local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(1, -20, 1, -110)
mainContainer.Position = UDim2.new(0, 10, 0, 95)
mainContainer.BackgroundTransparency = 1
mainContainer.Parent = backgroundFrame

-- Контент Executor
local executorFrame = Instance.new("Frame")
executorFrame.Size = UDim2.new(1, 0, 1, 0)
executorFrame.BackgroundTransparency = 1
executorFrame.Visible = true
executorFrame.Parent = mainContainer

-- Область скрипта
local scriptBox = Instance.new("TextBox")
scriptBox.Size = UDim2.new(1, 0, 0, 250)
scriptBox.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
scriptBox.TextColor3 = Color3.new(1, 1, 1)
scriptBox.Font = Enum.Font.Code
scriptBox.TextSize = 12
scriptBox.Text = "-- Введите ваш скрипт здесь\nprint('KRNL Mix Ready')"
scriptBox.TextXAlignment = Enum.TextXAlignment.Left
scriptBox.TextYAlignment = Enum.TextYAlignment.Top
scriptBox.ClearTextOnFocus = false
scriptBox.MultiLine = true
scriptBox.Parent = executorFrame

local scriptCorner = Instance.new("UICorner")
scriptCorner.CornerRadius = UDim.new(0, 8)
scriptCorner.Parent = scriptBox

-- Кнопки исполнения
local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(1, 0, 0, 45)
buttonFrame.Position = UDim2.new(0, 0, 0, 260)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = executorFrame

local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(0, 140, 0, 40)
executeButton.BackgroundColor3 = Color3.new(0, 0.7, 0)
executeButton.Text = "EXECUTE"
executeButton.TextColor3 = Color3.new(1, 1, 1)
executeButton.Font = Enum.Font.GothamBold
executeButton.TextSize = 14
executeButton.Parent = buttonFrame

local executeServer = Instance.new("TextButton")
executeServer.Size = UDim2.new(0, 160, 0, 40)
executeServer.Position = UDim2.new(0, 150, 0, 0)
executeServer.BackgroundColor3 = Color3.new(0.9, 0.5, 0)
executeServer.Text = "EXECUTE SERVER"
executeServer.TextColor3 = Color3.new(1, 1, 1)
executeServer.Font = Enum.Font.GothamBold
executeServer.TextSize = 14
executeServer.Parent = buttonFrame

local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.new(0, 120, 0, 40)
clearButton.Position = UDim2.new(0, 320, 0, 0)
clearButton.BackgroundColor3 = Color3.new(0.7, 0, 0)
clearButton.Text = "CLEAR"
clearButton.TextColor3 = Color3.new(1, 1, 1)
clearButton.Font = Enum.Font.GothamBold
clearButton.TextSize = 14
clearButton.Parent = buttonFrame

local execCorner = Instance.new("UICorner")
execCorner.CornerRadius = UDim.new(0, 8)
execCorner.Parent = executeButton
execCorner:Clone().Parent = executeServer
execCorner:Clone().Parent = clearButton

-- Консоль вывода
local outputFrame = Instance.new("Frame")
outputFrame.Size = UDim2.new(1, 0, 0, 120)
outputFrame.Position = UDim2.new(0, 0, 0, 315)
outputFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
outputFrame.Parent = executorFrame

local outputCorner = Instance.new("UICorner")
outputCorner.CornerRadius = UDim.new(0, 8)
outputCorner.Parent = outputFrame

local outputScrolling = Instance.new("ScrollingFrame")
outputScrolling.Size = UDim2.new(1, -10, 1, -10)
outputScrolling.Position = UDim2.new(0, 5, 0, 5)
outputScrolling.BackgroundTransparency = 1
outputScrolling.ScrollBarThickness = 6
outputScrolling.Parent = outputFrame

local outputLabel = Instance.new("TextLabel")
outputLabel.Size = UDim2.new(1, 0, 0, 0)
outputLabel.BackgroundTransparency = 1
outputLabel.Text = "> KRNL Mix initialized..."
outputLabel.TextColor3 = Color3.new(0, 1, 0)
outputLabel.Font = Enum.Font.Code
outputLabel.TextSize = 11
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.TextYAlignment = Enum.TextYAlignment.Top
outputLabel.TextWrapped = true
outputLabel.Parent = outputScrolling

-- Контент Settings
local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(1, 0, 1, 0)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Visible = false
settingsFrame.Parent = mainContainer

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, 0, 0, 30)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "GRAPHICS SETTINGS"
settingsTitle.TextColor3 = Color3.new(1, 1, 1)
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 18
settingsTitle.Parent = settingsFrame

-- Настройка FPS
local fpsFrame = Instance.new("Frame")
fpsFrame.Size = UDim2.new(1, 0, 0, 60)
fpsFrame.Position = UDim2.new(0, 0, 0, 40)
fpsFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
fpsFrame.Parent = settingsFrame

local fpsCorner = Instance.new("UICorner")
fpsCorner.CornerRadius = UDim.new(0, 8)
fpsCorner.Parent = fpsFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0.6, 0, 0, 25)
fpsLabel.Position = UDim2.new(0, 10, 0, 5)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS Limit: 60"
fpsLabel.TextColor3 = Color3.new(1, 1, 1)
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.TextSize = 14
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Parent = fpsFrame

local fpsSlider = Instance.new("TextBox")
fpsSlider.Size = UDim2.new(0, 100, 0, 30)
fpsSlider.Position = UDim2.new(1, -120, 0, 15)
fpsSlider.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
fpsSlider.Text = "60"
fpsSlider.TextColor3 = Color3.new(1, 1, 1)
fpsSlider.Font = Enum.Font.Gotham
fpsSlider.TextSize = 14
fpsSlider.Parent = fpsFrame

local fpsApply = Instance.new("TextButton")
fpsApply.Size = UDim2.new(0, 80, 0, 25)
fpsApply.Position = UDim2.new(0, 10, 0, 30)
fpsApply.BackgroundColor3 = Color3.new(0, 0.5, 0)
fpsApply.Text = "APPLY"
fpsApply.TextColor3 = Color3.new(1, 1, 1)
fpsApply.Font = Enum.Font.Gotham
fpsApply.TextSize = 12
fpsApply.Parent = fpsFrame

-- Кнопка ухудшения графики
local potatoMode = Instance.new("TextButton")
potatoMode.Size = UDim2.new(1, 0, 0, 50)
potatoMode.Position = UDim2.new(0, 0, 0, 120)
potatoMode.BackgroundColor3 = Color3.new(0.8, 0.3, 0)
potatoMode.Text = "POTATO MODE"
potatoMode.TextColor3 = Color3.new(1, 1, 1)
potatoMode.Font = Enum.Font.GothamBold
potatoMode.TextSize = 16
potatoMode.Parent = settingsFrame

local potatoCorner = Instance.new("UICorner")
potatoCorner.CornerRadius = UDim.new(0, 8)
potatoCorner.Parent = potatoMode

-- Контент Premium
local premiumFrame = Instance.new("Frame")
premiumFrame.Size = UDim2.new(1, 0, 1, 0)
premiumFrame.BackgroundTransparency = 1
premiumFrame.Visible = false
premiumFrame.Parent = mainContainer

local premiumTitle = Instance.new("TextLabel")
premiumTitle.Size = UDim2.new(1, 0, 0, 100)
premiumTitle.BackgroundTransparency = 1
premiumTitle.Text = "PREMIUM FEATURES"
premiumTitle.TextColor3 = Color3.new(1, 0.8, 0)
premiumTitle.Font = Enum.Font.GothamBold
premiumTitle.TextSize = 24
premiumTitle.Parent = premiumFrame

local premiumButton = Instance.new("TextButton")
premiumButton.Size = UDim2.new(0, 200, 0, 60)
premiumButton.Position = UDim2.new(0.5, -100, 0.5, -30)
premiumButton.BackgroundColor3 = Color3.new(1, 0.8, 0)
premiumButton.Text = "ACTIVATE PREMIUM"
premiumButton.TextColor3 = Color3.new(0, 0, 0)
premiumButton.Font = Enum.Font.GothamBold
premiumButton.TextSize = 16
premiumButton.Parent = premiumFrame

local premiumCorner = Instance.new("UICorner")
premiumCorner.CornerRadius = UDim.new(0, 12)
premiumCorner.Parent = premiumButton

-- Миниатюра
local miniIcon = Instance.new("TextButton")
miniIcon.Size = UDim2.new(0, 60, 0, 60)
miniIcon.Position = UDim2.new(0, 15, 0, 15)
miniIcon.BackgroundColor3 = Color3.new(0.9, 0, 0)
miniIcon.Text = "KM"
miniIcon.TextColor3 = Color3.new(1, 1, 1)
miniIcon.Font = Enum.Font.GothamBold
miniIcon.TextSize = 16
miniIcon.Visible = false
miniIcon.Parent = KMGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 10)
miniCorner.Parent = miniIcon

-- Анимация полосок и частиц
local stripeConnection
stripeConnection = RunService.Heartbeat:Connect(function(delta)
    for i, stripe in pairs(stripes) do
        local currentPos = stripe.Position.X.Offset
        local newPos = (currentPos - delta * 60) % 700
        stripe.Position = UDim2.new(0, newPos, 0, 0)
    end
    
    for i, particle in pairs(particles) do
        local currentX = particle.Position.X.Offset
        local currentY = particle.Position.Y.Offset
        local newX = (currentX + math.sin(tick() + i) * 0.5) % 650
        local newY = (currentY + math.cos(tick() + i) * 0.3) % 450
        particle.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- Перехват print функции
local originalPrint = print
function print(...)
    local args = {...}
    local outputText = ""
    for i, arg in ipairs(args) do
        outputText = outputText .. tostring(arg) .. (i < #args and "\t" or "")
    end
    
    -- Добавляем в консоль KRNL Mix
    outputLabel.Text = outputLabel.Text .. "\n> " .. outputText
    outputScrolling.CanvasSize = UDim2.new(0, 0, 0, outputLabel.TextBounds.Y)
    outputScrolling.CanvasPosition = Vector2.new(0, outputLabel.TextBounds.Y)
    
    -- Вызываем оригинальный print
    originalPrint(...)
end

-- Функции исполнения скриптов
local function executeScript(scriptSource, isServer)
    local success, result = pcall(function()
        if isServer then
            -- Серверное исполнение через обход
            local remote = Instance.new("RemoteEvent")
            remote.Parent = ReplicatedStorage
            remote:FireServer("execute", scriptSource)
            return "Server execution attempted"
        else
            -- Клиентское исполнение
            local loadedFunction = loadstring(scriptSource)
            if loadedFunction then
                return loadedFunction()
            else
                error("Syntax error in script")
            end
        end
    end)

    if success then
        print("Execution successful: " .. tostring(result))
    else
        print("Error: " .. tostring(result))
    end
end

-- Функция показа сообщения о запрете доступа
local function showAccessDenied()
    local accessGui = Instance.new("ScreenGui")
    accessGui.Parent = CoreGui
    
    local accessFrame = Instance.new("Frame")
    accessFrame.Size = UDim2.new(0, 400, 0, 200)
    accessFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    accessFrame.BackgroundColor3 = Color3.new(0.3, 0, 0)
    accessFrame.Parent = accessGui
    
    local accessCorner = Instance.new("UICorner")
    accessCorner.CornerRadius = UDim.new(0, 12)
    accessCorner.Parent = accessFrame
    
    local accessLabel = Instance.new("TextLabel")
    accessLabel.Size = UDim2.new(1, 0, 0, 100)
    accessLabel.BackgroundTransparency = 1
    accessLabel.Text = "НЕТ ДОСТУПА!"
    accessLabel.TextColor3 = Color3.new(1, 1, 1)
    accessLabel.Font = Enum.Font.GothamBold
    accessLabel.TextSize = 24
    accessLabel.Parent = accessFrame
    
    local closeAccess = Instance.new("TextButton")
    closeAccess.Size = UDim2.new(0, 120, 0, 40)
    closeAccess.Position = UDim2.new(0.5, -60, 1, -60)
    closeAccess.BackgroundColor3 = Color3.new(1, 0.2, 0.2)
    closeAccess.Text = "ЗАКРЫТЬ"
    closeAccess.TextColor3 = Color3.new(1, 1, 1)
    closeAccess.Font = Enum.Font.GothamBold
    closeAccess.TextSize = 16
    closeAccess.Parent = accessFrame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeAccess
    
    closeAccess.MouseButton1Click:Connect(function()
        accessGui:Destroy()
    end)
end

-- Функция Potato Mode
local function activatePotatoMode()
    -- Ухудшаем графику
    settings.RenderQuality = 1
    settings.SavedQualityLevel = 1
    
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100
    Lighting.Brightness = 2
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") then
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
        elseif obj:IsA("Decal") then
            obj.Transparency = 0.5
        elseif obj:IsA("ParticleEmitter") then
            obj.Enabled = false
        end
    end
    
    print("Potato Mode activated - worst graphics applied")
end

-- Функция смены вкладок
local function switchTab(tabName)
    executorFrame.Visible = false
    settingsFrame.Visible = false
    premiumFrame.Visible = false
    
    -- Сбрасываем цвет всех кнопок
    for name, button in pairs(tabButtons) do
        button.BackgroundColor3 = Color3.new(0.2, 0, 0)
    end
    
    -- Устанавливаем активную вкладку
    if tabName == "Executor" then
        executorFrame.Visible = true
        tabButtons.Executor.BackgroundColor3 = Color3.new(0.4, 0, 0)
    elseif tabName == "Settings" then
        settingsFrame.Visible = true
        tabButtons.Settings.BackgroundColor3 = Color3.new(0.4, 0, 0)
    elseif tabName == "Premium" then
        premiumFrame.Visible = true
        tabButtons.Premium.BackgroundColor3 = Color3.new(0.4, 0, 0)
    end
    
    currentTab = tabName
end

-- Обработчики событий вкладок
for tabName, button in pairs(tabButtons) do
    button.MouseButton1Click:Connect(function()
        switchTab(tabName)
    end)
end

-- Обработчики кнопок управления
minimizeButton.MouseButton1Click:Connect(function()
    backgroundFrame.Visible = false
    miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
    backgroundFrame.Visible = true
    miniIcon.Visible = false
end)

closeButton.MouseButton1Click:Connect(function()
    local confirmGui = Instance.new("ScreenGui")
    confirmGui.Parent = CoreGui
    
    local confirmFrame = Instance.new("Frame")
    confirmFrame.Size = UDim2.new(0, 300, 0, 150)
    confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    confirmFrame.BackgroundColor3 = Color3.new(0.2, 0, 0)
    confirmFrame.Parent = confirmGui
    
    local confirmCorner = Instance.new("UICorner")
    confirmCorner.CornerRadius = UDim.new(0, 8)
    confirmCorner.Parent = confirmFrame
    
    local confirmLabel = Instance.new("TextLabel")
    confirmLabel.Size = UDim2.new(1, 0, 0, 60)
    confirmLabel.BackgroundTransparency = 1
    confirmLabel.Text = "Close KRNL Mix?"
    confirmLabel.TextColor3 = Color3.new(1, 1, 1)
    confirmLabel.Font = Enum.Font.GothamBold
    confirmLabel.TextSize = 16
    confirmLabel.Parent = confirmFrame
    
    local yesButton = Instance.new("TextButton")
    yesButton.Size = UDim2.new(0, 100, 0, 35)
    yesButton.Position = UDim2.new(0, 40, 1, -50)
    yesButton.BackgroundColor3 = Color3.new(1, 0, 0)
    yesButton.Text = "YES"
    yesButton.TextColor3 = Color3.new(1, 1, 1)
    yesButton.Font = Enum.Font.GothamBold
    yesButton.Parent = confirmFrame
    
    local noButton = Instance.new("TextButton")
    noButton.Size = UDim2.new(0, 100, 0, 35)
    noButton.Position = UDim2.new(1, -140, 1, -50)
    noButton.BackgroundColor3 = Color3.new(0, 0.6, 0)
    noButton.Text = "NO"
    noButton.TextColor3 = Color3.new(1, 1, 1)
    noButton.Font = Enum.Font.GothamBold
    noButton.Parent = confirmFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = yesButton
    buttonCorner:Clone().Parent = noButton
    
    yesButton.MouseButton1Click:Connect(function()
        stripeConnection:Disconnect()
        KMGui:Destroy()
        confirmGui:Destroy()
    end)
    
    noButton.MouseButton1Click:Connect(function()
        confirmGui:Destroy()
    end)
end)

-- Обработчики кнопок Executor
executeButton.MouseButton1Click:Connect(function()
    executeScript(scriptBox.Text, false)
end)

executeServer.MouseButton1Click:Connect(function()
    executeScript(scriptBox.Text, true)
end)

clearButton.MouseButton1Click:Connect(function()
    scriptBox.Text = ""
    outputLabel.Text = "> Console cleared"
    outputScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
end)

-- Обработчики Settings
fpsApply.MouseButton1Click:Connect(function()
    local fpsValue = tonumber(fpsSlider.Text)
    if fpsValue and fpsValue > 0 and fpsValue <= 1000 then
        settings().Rendering.Framerate = fpsValue
        fpsLabel.Text = "FPS Limit: " .. fpsValue
        print("FPS limit set to: " .. fpsValue)
    else
        print("Invalid FPS value")
    end
end)

potatoMode.MouseButton1Click:Connect(function()
    activatePotatoMode()
end)

-- Обработчик Premium кнопки
premiumButton.MouseButton1Click:Connect(function()
    showAccessDenied()
end)

-- Система перетаскивания
local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = backgroundFrame.Position
        
        -- Анимация нажатия
        local tween = TweenService:Create(titleBar, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(0.4, 0, 0)})
        tween:Play()
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        
        -- Возвращаем цвет
        local tween = TweenService:Create(titleBar, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(0.25, 0, 0)})
        tween:Play()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        backgroundFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                           startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Автоматическое обновление консоли
RunService.Heartbeat:Connect(function()
    outputScrolling.CanvasSize = UDim2.new(0, 0, 0, outputLabel.TextBounds.Y + 10)
    if outputLabel.TextBounds.Y > outputScrolling.AbsoluteSize.Y then
        outputScrolling.CanvasPosition = Vector2.new(0, outputLabel.TextBounds.Y)
    end
end)

-- Инициализация
switchTab("Executor")
print("KRNL Mix loaded successfully!")
print("Executor: Client-side script execution")
print("Settings: Graphics and performance controls")
print("Premium: Locked features (no access)")

-- Дополнительные эффекты для красоты
local glowEffect = Instance.new("Frame")
glowEffect.Size = UDim2.new(1, 20, 1, 20)
glowEffect.Position = UDim2.new(0, -10, 0, -10)
glowEffect.BackgroundColor3 = Color3.new(1, 0, 0)
glowEffect.BackgroundTransparency = 0.9
glowEffect.BorderSizePixel = 0
glowEffect.ZIndex = -1
glowEffect.Parent = backgroundFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 20)
glowCorner.Parent = glowEffect

-- Анимация свечения
while true do
    wait(2)
    local tween1 = TweenService:Create(glowEffect, TweenInfo.new(1), {BackgroundTransparency = 0.8})
    local tween2 = TweenService:Create(glowEffect, TweenInfo.new(1), {BackgroundTransparency = 0.95})
    tween1:Play()
    wait(1)
    tween2:Play()
end