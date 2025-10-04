-- KRNL Mix Beta 0.0.3
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")

local localPlayer = Players.LocalPlayer

-- Key System
local correctKey = "krnlmix-free"
local keyVerified = false

-- Main Interface Function
local function loadMainInterface()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "KRNLMix"
    mainGui.Parent = CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 700, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = mainGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.new(0.2, 0, 0)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -80, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "KRNL MIX BETA 0.0.3"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0, 5)
    closeButton.BackgroundColor3 = Color3.new(1, 0.2, 0.2)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 14
    closeButton.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeButton

    -- Tabs
    local tabsContainer = Instance.new("Frame")
    tabsContainer.Size = UDim2.new(1, 0, 0, 40)
    tabsContainer.Position = UDim2.new(0, 0, 0, 40)
    tabsContainer.BackgroundTransparency = 1
    tabsContainer.Parent = mainFrame

    local tabs = {"Executor", "Scripts", "Search", "Telegram"}
    local tabFrames = {}
    local tabButtons = {}

    for i, tabName in pairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 120, 0, 35)
        tabButton.Position = UDim2.new(0, (i-1) * 125, 0, 2)
        tabButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.new(1, 1, 1)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.Parent = tabsContainer

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tabButton

        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, -20, 1, -90)
        tabFrame.Position = UDim2.new(0, 10, 0, 90)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = mainFrame

        tabFrames[tabName] = tabFrame
        tabButtons[tabName] = tabButton

        tabButton.MouseButton1Click:Connect(function()
            for name, frame in pairs(tabFrames) do
                frame.Visible = false
                tabButtons[name].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
            end
            tabFrame.Visible = true
            tabButton.BackgroundColor3 = Color3.new(0.3, 0, 0)
        end)
    end

    -- Executor Tab Content
    local executorFrame = tabFrames["Executor"]
    
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(1, 0, 0, 200)
    scriptBox.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
    scriptBox.TextColor3 = Color3.new(1, 1, 1)
    scriptBox.Font = Enum.Font.Code
    scriptBox.TextSize = 12
    scriptBox.Text = "print('KRNL Mix Beta 0.0.3 Loaded!')"
    scriptBox.TextXAlignment = Enum.TextXAlignment.Left
    scriptBox.TextYAlignment = Enum.TextYAlignment.Top
    scriptBox.ClearTextOnFocus = false
    scriptBox.MultiLine = true
    scriptBox.Parent = executorFrame

    local scriptCorner = Instance.new("UICorner")
    scriptCorner.CornerRadius = UDim.new(0, 8)
    scriptCorner.Parent = scriptBox

    local executeButton = Instance.new("TextButton")
    executeButton.Size = UDim2.new(0, 120, 0, 35)
    executeButton.Position = UDim2.new(0, 0, 0, 210)
    executeButton.BackgroundColor3 = Color3.new(0, 0.6, 0)
    executeButton.Text = "EXECUTE"
    executeButton.TextColor3 = Color3.new(1, 1, 1)
    executeButton.Font = Enum.Font.GothamBold
    executeButton.TextSize = 14
    executeButton.Parent = executorFrame

    local execCorner = Instance.new("UICorner")
    execCorner.CornerRadius = UDim.new(0, 8)
    execCorner.Parent = executeButton

    local clearButton = Instance.new("TextButton")
    clearButton.Size = UDim2.new(0, 120, 0, 35)
    clearButton.Position = UDim2.new(0, 130, 0, 210)
    clearButton.BackgroundColor3 = Color3.new(0.6, 0, 0)
    clearButton.Text = "CLEAR"
    clearButton.TextColor3 = Color3.new(1, 1, 1)
    clearButton.Font = Enum.Font.GothamBold
    clearButton.TextSize = 14
    clearButton.Parent = executorFrame

    local clearCorner = Instance.new("UICorner")
    clearCorner.CornerRadius = UDim.new(0, 8)
    clearCorner.Parent = clearButton

    local outputFrame = Instance.new("Frame")
    outputFrame.Size = UDim2.new(1, 0, 0, 80)
    outputFrame.Position = UDim2.new(0, 0, 0, 255)
    outputFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    outputFrame.Parent = executorFrame

    local outputCorner = Instance.new("UICorner")
    outputCorner.CornerRadius = UDim.new(0, 8)
    outputCorner.Parent = outputFrame

    local outputLabel = Instance.new("TextLabel")
    outputLabel.Size = UDim2.new(1, -10, 1, -10)
    outputLabel.Position = UDim2.new(0, 5, 0, 5)
    outputLabel.BackgroundTransparency = 1
    outputLabel.Text = "> Ready for execution..."
    outputLabel.TextColor3 = Color3.new(0, 1, 0)
    outputLabel.Font = Enum.Font.Code
    outputLabel.TextSize = 11
    outputLabel.TextXAlignment = Enum.TextXAlignment.Left
    outputLabel.TextYAlignment = Enum.TextYAlignment.Top
    outputLabel.TextWrapped = true
    outputLabel.Parent = outputFrame

    -- Scripts Tab Content
    local scriptsFrame = tabFrames["Scripts"]
    
    local savedScripts = {
        {"Infinite Yield", "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()"},
        {"Simple Fly", "loadstring(game:HttpGet('https://raw.githubusercontent.com/XNEOFF/FlyGui/main/FlyGui'))()"},
        {"ESP", "loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()"}
    }

    local scriptsList = Instance.new("ScrollingFrame")
    scriptsList.Size = UDim2.new(1, 0, 1, 0)
    scriptsList.BackgroundTransparency = 1
    scriptsList.ScrollBarThickness = 6
    scriptsList.Parent = scriptsFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = scriptsList

    for i, scriptData in pairs(savedScripts) do
        local scriptButton = Instance.new("TextButton")
        scriptButton.Size = UDim2.new(1, -10, 0, 40)
        scriptButton.Position = UDim2.new(0, 5, 0, (i-1)*45)
        scriptButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        scriptButton.Text = scriptData[1]
        scriptButton.TextColor3 = Color3.new(1, 1, 1)
        scriptButton.Font = Enum.Font.Gotham
        scriptButton.TextSize = 14
        scriptButton.Parent = scriptsList

        local scriptCorner = Instance.new("UICorner")
        scriptCorner.CornerRadius = UDim.new(0, 6)
        scriptCorner.Parent = scriptButton

        scriptButton.MouseButton1Click:Connect(function()
            scriptBox.Text = scriptData[2]
            tabButtons["Executor"].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
            tabFrames["Executor"].Visible = true
            tabButtons["Executor"].BackgroundColor3 = Color3.new(0.3, 0, 0)
            tabFrames["Scripts"].Visible = false
        end)
    end

    scriptsList.CanvasSize = UDim2.new(0, 0, 0, #savedScripts * 45)

    -- Search Tab Content
    local searchFrame = tabFrames["Search"]
    
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, -100, 0, 35)
    searchBox.Position = UDim2.new(0, 0, 0, 0)
    searchBox.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
    searchBox.PlaceholderText = "Search scripts from ScriptBlox..."
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.new(1, 1, 1)
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 14
    searchBox.Parent = searchFrame

    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 6)
    searchCorner.Parent = searchBox

    local searchButton = Instance.new("TextButton")
    searchButton.Size = UDim2.new(0, 80, 0, 35)
    searchButton.Position = UDim2.new(1, -80, 0, 0)
    searchButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
    searchButton.Text = "SEARCH"
    searchButton.TextColor3 = Color3.new(1, 1, 1)
    searchButton.Font = Enum.Font.GothamBold
    searchButton.TextSize = 14
    searchButton.Parent = searchFrame

    local searchBtnCorner = Instance.new("UICorner")
    searchBtnCorner.CornerRadius = UDim.new(0, 6)
    searchBtnCorner.Parent = searchButton

    local searchResults = Instance.new("ScrollingFrame")
    searchResults.Size = UDim2.new(1, 0, 1, -45)
    searchResults.Position = UDim2.new(0, 0, 0, 45)
    searchResults.BackgroundTransparency = 1
    searchResults.ScrollBarThickness = 6
    searchResults.Parent = searchFrame

    local resultsLayout = Instance.new("UIListLayout")
    resultsLayout.Padding = UDim.new(0, 5)
    resultsLayout.Parent = searchResults

    -- Telegram Tab Content
    local telegramFrame = tabFrames["Telegram"]
    
    local telegramLabel = Instance.new("TextLabel")
    telegramLabel.Size = UDim2.new(1, 0, 0, 100)
    telegramLabel.BackgroundTransparency = 1
    telegramLabel.Text = "Join our Telegram channel for updates and new scripts!"
    telegramLabel.TextColor3 = Color3.new(1, 1, 1)
    telegramLabel.Font = Enum.Font.Gotham
    telegramLabel.TextSize = 16
    telegramLabel.TextWrapped = true
    telegramLabel.Parent = telegramFrame

    local telegramButton = Instance.new("TextButton")
    telegramButton.Size = UDim2.new(0, 200, 0, 50)
    telegramButton.Position = UDim2.new(0.5, -100, 0.5, -25)
    telegramButton.BackgroundColor3 = Color3.new(0, 0.5, 0.8)
    telegramButton.Text = "OPEN TELEGRAM"
    telegramButton.TextColor3 = Color3.new(1, 1, 1)
    telegramButton.Font = Enum.Font.GothamBold
    telegramButton.TextSize = 16
    telegramButton.Parent = telegramFrame

    local telegramCorner = Instance.new("UICorner")
    telegramCorner.CornerRadius = UDim.new(0, 8)
    telegramCorner.Parent = telegramButton

    -- Functions
    local originalPrint = print
    function print(...)
        local args = {...}
        local outputText = ""
        for i, arg in ipairs(args) do
            outputText = outputText .. tostring(arg) .. (i < #args and "\t" or "")
        end
        
        outputLabel.Text = outputLabel.Text .. "\n> " .. outputText
        originalPrint(...)
    end

    local function executeScript()
        local success, result = pcall(function()
            local loadedFunction = loadstring(scriptBox.Text)
            if loadedFunction then
                return loadedFunction()
            else
                error("Syntax error in script")
            end
        end)

        if success then
            print("Execution successful: " .. tostring(result))
        else
            print("Error: " .. tostring(result))
        end
    end

    local function searchScriptBlox(query)
        searchResults:ClearAllChildren()
        
        local mockResults = {
            {"Infinite Yield", "Popular admin commands", "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()"},
            {"Dark Hub", "All games hub", "loadstring(game:HttpGet('https://raw.githubusercontent.com/RandomAdamYT/DarkHub/master/Init'))()"},
            {"Owl Hub", "Multiple games support", "loadstring(game:HttpGet('https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt'))()"},
            {"CMD-X", "Admin commands", "loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))()"},
            {"Simple Spy", "Remote spy", "loadstring(game:HttpGet('https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua'))()"}
        }
        
        local filteredResults = {}
        for _, result in pairs(mockResults) do
            if string.find(string.lower(result[1]), string.lower(query)) or 
               string.find(string.lower(result[2]), string.lower(query)) then
                table.insert(filteredResults, result)
            end
        end
        
        if #filteredResults == 0 then
            local noResults = Instance.new("TextLabel")
            noResults.Size = UDim2.new(1, 0, 0, 50)
            noResults.BackgroundTransparency = 1
            noResults.Text = "No scripts found for: " .. query
            noResults.TextColor3 = Color3.new(1, 1, 1)
            noResults.Font = Enum.Font.Gotham
            noResults.TextSize = 14
            noResults.Parent = searchResults
        else
            for i, result in pairs(filteredResults) do
                local resultFrame = Instance.new("Frame")
                resultFrame.Size = UDim2.new(1, -10, 0, 80)
                resultFrame.Position = UDim2.new(0, 5, 0, (i-1)*85)
                resultFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
                resultFrame.Parent = searchResults

                local resultCorner = Instance.new("UICorner")
                resultCorner.CornerRadius = UDim.new(0, 6)
                resultCorner.Parent = resultFrame

                local titleLabel = Instance.new("TextLabel")
                titleLabel.Size = UDim2.new(1, -10, 0, 25)
                titleLabel.Position = UDim2.new(0, 5, 0, 5)
                titleLabel.BackgroundTransparency = 1
                titleLabel.Text = result[1]
                titleLabel.TextColor3 = Color3.new(1, 1, 1)
                titleLabel.Font = Enum.Font.GothamBold
                titleLabel.TextSize = 14
                titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                titleLabel.Parent = resultFrame

                local descLabel = Instance.new("TextLabel")
                descLabel.Size = UDim2.new(1, -10, 0, 20)
                descLabel.Position = UDim2.new(0, 5, 0, 30)
                descLabel.BackgroundTransparency = 1
                descLabel.Text = result[2]
                descLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
                descLabel.Font = Enum.Font.Gotham
                descLabel.TextSize = 12
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.Parent = resultFrame

                local loadButton = Instance.new("TextButton")
                loadButton.Size = UDim2.new(0, 80, 0, 25)
                loadButton.Position = UDim2.new(1, -85, 1, -30)
                loadButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
                loadButton.Text = "LOAD"
                loadButton.TextColor3 = Color3.new(1, 1, 1)
                loadButton.Font = Enum.Font.Gotham
                loadButton.TextSize = 12
                loadButton.Parent = resultFrame

                local loadCorner = Instance.new("UICorner")
                loadCorner.CornerRadius = UDim.new(0, 4)
                loadCorner.Parent = loadButton

                loadButton.MouseButton1Click:Connect(function()
                    scriptBox.Text = result[3]
                    tabButtons["Executor"].BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
                    tabFrames["Executor"].Visible = true
                    tabButtons["Executor"].BackgroundColor3 = Color3.new(0.3, 0, 0)
                    tabFrames["Search"].Visible = false
                    print("Loaded script: " .. result[1])
                end)
            end
        end
        
        searchResults.CanvasSize = UDim2.new(0, 0, 0, #filteredResults * 85)
    end

    -- Event Connections
    executeButton.MouseButton1Click:Connect(executeScript)

    clearButton.MouseButton1Click:Connect(function()
        scriptBox.Text = ""
        outputLabel.Text = "> Console cleared"
    end)

    searchButton.MouseButton1Click:Connect(function()
        if searchBox.Text ~= "" then
            searchScriptBlox(searchBox.Text)
        end
    end)

    searchBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and searchBox.Text ~= "" then
            searchScriptBlox(searchBox.Text)
        end
    end)

    telegramButton.MouseButton1Click:Connect(function()
        setclipboard("https://t.me/krnlmix")
        print("Telegram link copied to clipboard!")
    end)

    closeButton.MouseButton1Click:Connect(function()
        mainGui:Destroy()
    end)

    -- Set default tab
    tabFrames["Executor"].Visible = true
    tabButtons["Executor"].BackgroundColor3 = Color3.new(0.3, 0, 0)

    -- Dragging
    local dragging = false
    local dragStart, startPos

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                         startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    print("KRNL Mix Beta 0.0.3 loaded successfully!")
end

-- Key Verification GUI
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KRNLKeySystem"
keyGui.Parent = CoreGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 400, 0, 250)
keyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
keyFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 12)
keyCorner.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 60)
keyTitle.BackgroundColor3 = Color3.new(0.2, 0, 0)
keyTitle.Text = "KRNL MIX - KEY SYSTEM"
keyTitle.TextColor3 = Color3.new(1, 1, 1)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 18
keyTitle.Parent = keyFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = keyTitle

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0, 300, 0, 40)
keyInput.Position = UDim2.new(0.5, -150, 0.5, -40)
keyInput.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
keyInput.PlaceholderText = "Enter key..."
keyInput.Text = ""
keyInput.TextColor3 = Color3.new(1, 1, 1)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 14
keyInput.Parent = keyFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = keyInput

local verifyButton = Instance.new("TextButton")
verifyButton.Size = UDim2.new(0, 120, 0, 35)
verifyButton.Position = UDim2.new(0.5, -60, 0.5, 20)
verifyButton.BackgroundColor3 = Color3.new(0, 0.6, 0)
verifyButton.Text = "VERIFY"
verifyButton.TextColor3 = Color3.new(1, 1, 1)
verifyButton.Font = Enum.Font.GothamBold
verifyButton.TextSize = 14
verifyButton.Parent = keyFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = verifyButton

local hintLabel = Instance.new("TextLabel")
hintLabel.Size = UDim2.new(1, 0, 0, 30)
hintLabel.Position = UDim2.new(0, 0, 1, -40)
hintLabel.BackgroundTransparency = 1
hintLabel.Text = "Hint: Type '/krnlmix key krnlmix-free' in chat"
hintLabel.TextColor3 = Color3.new(1, 1, 1)
hintLabel.Font = Enum.Font.Gotham
hintLabel.TextSize = 12
hintLabel.Parent = keyFrame

-- Chat command handler
local function onChatMessage(message, speaker)
    if speaker == localPlayer then
        if message:lower() == "/krnlmix key krnlmix-free" then
            keyVerified = true
            keyGui:Destroy()
            loadMainInterface()
        end
    end
end

-- Verify key function
local function verifyKey()
    if keyInput.Text == correctKey then
        keyVerified = true
        keyGui:Destroy()
        loadMainInterface()
    else
        keyInput.Text = ""
        keyInput.PlaceholderText = "Wrong key! Try again..."
    end
end

verifyButton.MouseButton1Click:Connect(verifyKey)

keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        verifyKey()
    end
end)

-- Connect chat listener
game:GetService("Players").PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onChatMessage(message, player)
    end)
end)

for _, player in pairs(Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        onChatMessage(message, player)
    end
end

-- Auto-show changelog after 2 seconds
wait(2)
local changelogGui = Instance.new("ScreenGui")
changelogGui.Name = "KRNLChangelog"
changelogGui.Parent = CoreGui

local changelogFrame = Instance.new("Frame")
changelogFrame.Size = UDim2.new(0, 500, 0, 400)
changelogFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
changelogFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
changelogFrame.BorderSizePixel = 0
changelogFrame.Parent = changelogGui

local changelogCorner = Instance.new("UICorner")
changelogCorner.CornerRadius = UDim.new(0, 12)
changelogCorner.Parent = changelogFrame

local changelogTitle = Instance.new("TextLabel")
changelogTitle.Size = UDim2.new(1, 0, 0, 50)
changelogTitle.BackgroundColor3 = Color3.new(0.2, 0, 0)
changelogTitle.Text = "Changelog Beta 0.0.3"
changelogTitle.TextColor3 = Color3.new(1, 1, 1)
changelogTitle.Font = Enum.Font.GothamBold
changelogTitle.TextSize = 18
changelogTitle.Parent = changelogFrame

local titleCLCorner = Instance.new("UICorner")
titleCLCorner.CornerRadius = UDim.new(0, 12)
titleCLCorner.Parent = changelogTitle

local changelogText = Instance.new("TextLabel")
changelogText.Size = UDim2.new(1, -20, 1, -80)
changelogText.Position = UDim2.new(0, 10, 0, 60)
changelogText.BackgroundTransparency = 1
changelogText.Text = "- Обновление UI (Убраны анимации)\n- Оптимизирован и обсуцифицирован скрипт\n- Убраны настройки\n- Улучшение UI (Добавлена вкладка Tabs - Сохранение скриптов)\n- Добавлена ключ система (Ключ: krnlmix-free)\n- Добавлена ссылка на Телеграмм\n- Добавлена вкладка Search (ScriptBlox)"
changelogText.TextColor3 = Color3.new(1, 1, 1)
changelogText.Font = Enum.Font.Gotham
changelogText.TextSize = 14
changelogText.TextXAlignment = Enum.TextXAlignment.Left
changelogText.TextYAlignment = Enum.TextYAlignment.Top
changelogText.TextWrapped = true
changelogText.Parent = changelogFrame

local closeChangelog = Instance.new("TextButton")
closeChangelog.Size = UDim2.new(0, 120, 0, 35)
closeChangelog.Position = UDim2.new(0.5, -60, 1, -45)
closeChangelog.BackgroundColor3 = Color3.new(0, 0.6, 0)
closeChangelog.Text = "CLOSE"
closeChangelog.TextColor3 = Color3.new(1, 1, 1)
closeChangelog.Font = Enum.Font.GothamBold
closeChangelog.TextSize = 14
closeChangelog.Parent = changelogFrame

local closeCLCorner = Instance.new("UICorner")
closeCLCorner.CornerRadius = UDim.new(0, 8)
closeCLCorner.Parent = closeChangelog

closeChangelog.MouseButton1Click:Connect(function()
    changelogGui:Destroy()
end)