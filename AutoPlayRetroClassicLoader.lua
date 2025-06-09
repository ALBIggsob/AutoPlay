local Speed = 100
local ShowLines = true
local TotalBuildTime = 3
local AntiStuckEnabled = true
local OutOfTrackRadius = 5

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local trackPoints = {
Vector3.new(40.94, 4.00, 955.39),
Vector3.new(54.31, 4.00, 956.94),
Vector3.new(70.50, 4.00, 957.43),
Vector3.new(89.16, 10.64, 958.12),
Vector3.new(108.04, 33.99, 961.55),
Vector3.new(129.55, 37.36, 965.58),
Vector3.new(149.06, 28.98, 964.26),
Vector3.new(166.39, 33.70, 954.00),
Vector3.new(184.06, 50.17, 943.50),
Vector3.new(201.41, 60.42, 933.47),
Vector3.new(211.78, 86.47, 926.66),
Vector3.new(219.22, 92.29, 922.76),
Vector3.new(236.51, 81.75, 915.55),
Vector3.new(256.74, 82.00, 912.91),
Vector3.new(278.75, 90.33, 912.28),
Vector3.new(300.41, 98.91, 911.48),
Vector3.new(321.83, 109.90, 909.80),
Vector3.new(343.08, 101.83, 908.61),
Vector3.new(364.26, 99.14, 907.42),
Vector3.new(385.44, 97.39, 906.52),
Vector3.new(407.16, 87.99, 906.02),
Vector3.new(428.58, 94.24, 907.64),
Vector3.new(449.00, 100.57, 909.10),
Vector3.new(469.39, 109.53, 910.70),
Vector3.new(491.32, 98.55, 912.90),
Vector3.new(507.89, 96.00, 923.52),
Vector3.new(525.30, 96.00, 937.30),
Vector3.new(540.61, 108.15, 952.40),
Vector3.new(555.09, 123.17, 967.67),
Vector3.new(570.81, 130.68, 982.97),
Vector3.new(587.44, 146.09, 997.30),
Vector3.new(604.92, 165.61, 1010.55),
Vector3.new(622.43, 166.81, 1023.74),
Vector3.new(621.43, 168.00, 1043.12),
Vector3.new(609.77, 174.96, 1056.83),
Vector3.new(630.28, 191.36, 1057.15),
Vector3.new(650.52, 196.54, 1064.19),
Vector3.new(657.93, 200.54, 1068.45),
Vector3.new(673.57, 216.23, 1082.27),
Vector3.new(690.89, 230.16, 1094.86),
Vector3.new(709.52, 228.26, 1106.03),
Vector3.new(725.25, 220.10, 1117.27),
Vector3.new(724.15, 236.83, 1137.98),
Vector3.new(719.07, 250.88, 1148.69),
Vector3.new(711.23, 253.92, 1153.37),
Vector3.new(691.54, 252.30, 1159.66),
Vector3.new(670.05, 261.34, 1163.16),
Vector3.new(648.62, 274.86, 1165.34),
Vector3.new(627.75, 275.53, 1169.97),
Vector3.new(601.65, 286.18, 1171.98),
Vector3.new(582.03, 292.20, 1160.96),
Vector3.new(568.05, 298.10, 1145.35),
Vector3.new(555.58, 286.10, 1127.62),
Vector3.new(540.50, 270.30, 1114.10),
Vector3.new(521.56, 270.30, 1102.93),
Vector3.new(503.44, 279.31, 1089.78),
Vector3.new(485.61, 269.06, 1078.10),
Vector3.new(466.56, 276.42, 1066.58),
Vector3.new(448.41, 283.23, 1055.51),
Vector3.new(436.57, 271.50, 1050.37),
Vector3.new(437.05, 270.79, 1050.37),
Vector3.new(423.58, 283.31, 1051.17),
Vector3.new(400.31, 288.31, 1053.88),
Vector3.new(377.09, 274.14, 1057.08),
Vector3.new(354.92, 260.79, 1060.14),
Vector3.new(335.58, 275.37, 1062.68),
Vector3.new(315.41, 276.81, 1064.82),
Vector3.new(295.49, 264.66, 1066.29),
Vector3.new(277.05, 272.80, 1066.54),
Vector3.new(256.10, 277.63, 1066.11),
Vector3.new(235.70, 263.43, 1065.61),
Vector3.new(215.20, 242.23, 1065.29),
Vector3.new(194.78, 242.56, 1064.98),
Vector3.new(176.43, 241.00, 1065.70),
Vector3.new(156.88, 241.00, 1069.52),
Vector3.new(136.30, 240.78, 1074.09),
Vector3.new(115.35, 231.86, 1078.90),
Vector3.new(94.23, 232.00, 1081.51),
Vector3.new(72.47, 239.05, 1083.42),
Vector3.new(50.60, 251.48, 1085.06),
Vector3.new(29.55, 261.48, 1086.32),
Vector3.new(7.63, 261.91, 1086.65),
Vector3.new(1.13, 269.09, 1069.14),
Vector3.new(0.52, 282.18, 1047.47),
Vector3.new(0.22, 289.46, 1026.58),
Vector3.new(7.66, 281.17, 1005.54),
Vector3.new(15.52, 297.15, 986.88),
Vector3.new(21.07, 310.92, 966.68),
Vector3.new(19.41, 324.23, 945.70),
Vector3.new(20.11, 323.74, 924.35),
Vector3.new(21.16, 325.51, 902.03),
Vector3.new(19.92, 312.65, 879.88),
Vector3.new(15.86, 328.42, 859.47),
Vector3.new(11.99, 334.85, 838.83),
Vector3.new(5.45, 322.96, 819.43),
Vector3.new(1.39, 318.99, 799.78),
Vector3.new(0.30, 335.81, 777.75),
Vector3.new(0.81, 358.78, 755.20),
Vector3.new(1.39, 374.95, 733.15),
Vector3.new(1.67, 389.29, 712.60),
Vector3.new(1.93, 414.60, 691.27),
Vector3.new(3.68, 421.17, 669.42),
Vector3.new(5.29, 408.97, 648.47),
Vector3.new(0.84, 402.59, 628.22),
Vector3.new(-7.47, 408.37, 610.09),
Vector3.new(-17.14, 424.09, 590.63),
Vector3.new(-27.09, 427.11, 571.78),
Vector3.new(-29.79, 431.94, 551.59),
Vector3.new(-21.65, 439.64, 530.49),
Vector3.new(-7.88, 447.00, 513.02),
Vector3.new(5.85, 456.02, 498.72),
Vector3.new(19.37, 462.52, 484.22),
Vector3.new(33.24, 459.43, 469.84),
Vector3.new(48.61, 450.62, 458.82),
Vector3.new(66.35, 459.88, 450.84),
Vector3.new(82.15, 450.13, 440.67),
Vector3.new(98.62, 463.78, 429.23),
Vector3.new(115.64, 457.95, 418.59),
Vector3.new(119.75, 453.25, 395.95),
Vector3.new(118.69, 463.57, 373.19),
Vector3.new(113.47, 477.90, 355.73),
Vector3.new(106.68, 483.90, 337.84),
Vector3.new(107.65, 483.00, 319.40),
Vector3.new(114.65, 493.23, 301.78),
Vector3.new(120.78, 496.75, 282.68),
Vector3.new(124.75, 491.00, 262.89),
Vector3.new(135.51, 494.22, 246.52),
Vector3.new(152.42, 497.84, 235.53),
Vector3.new(169.68, 512.27, 224.45),
Vector3.new(186.80, 513.80, 213.53),
Vector3.new(204.21, 519.72, 202.47),
Vector3.new(221.71, 516.86, 191.55),
Vector3.new(238.98, 542.22, 181.24),
Vector3.new(259.04, 550.92, 172.10),
Vector3.new(276.85, 541.62, 161.78),
Vector3.new(287.87, 544.19, 146.34),
Vector3.new(299.06, 561.12, 131.31),
Vector3.new(313.30, 572.67, 127.39),
Vector3.new(317.03, 581.55, 131.34),
Vector3.new(331.98, 570.99, 137.70),
Vector3.new(356.00, 576.64, 131.00),
Vector3.new(380.90, 574.87, 131.00),
Vector3.new(410.90, 572.78, 131.00),
Vector3.new(445.77, 570.36, 131.00),
Vector3.new(484.37, 567.67, 131.00),
Vector3.new(528.23, 564.62, 131.00),
Vector3.new(575.61, 561.32, 131.00),
Vector3.new(606.27, 576.07, 121.45),
Vector3.new(620.09, 591.78, 103.09),
Vector3.new(630.61, 590.46, 86.60),
Vector3.new(645.62, 587.00, 74.41),
Vector3.new(657.30, 587.00, 57.93),
Vector3.new(659.94, 587.00, 36.38),
Vector3.new(662.10, 587.00, 14.90),
Vector3.new(663.31, 596.00, -7.17),
Vector3.new(664.77, 587.29, -29.04),
Vector3.new(665.79, 559.40, -50.44),
Vector3.new(666.30, 565.25, -71.95),
Vector3.new(666.70, 569.40, -92.15),
Vector3.new(669.83, 554.61, -113.00),
Vector3.new(674.46, 559.87, -133.05),
Vector3.new(677.56, 554.85, -153.82),
Vector3.new(678.50, 546.52, -175.00),
Vector3.new(677.18, 536.25, -196.41),
Vector3.new(674.84, 552.23, -216.77),
Vector3.new(672.19, 551.28, -237.74),
Vector3.new(669.52, 548.13, -258.48),
Vector3.new(666.77, 568.45, -280.27),
Vector3.new(664.18, 586.68, -301.52),
Vector3.new(661.73, 585.37, -322.50),
Vector3.new(659.38, 565.71, -342.93),
Vector3.new(657.33, 537.68, -361.72),
Vector3.new(655.12, 538.00, -381.98),
}

local trackFolder = Instance.new("Folder")
trackFolder.Name = "TrackLines"
trackFolder.Parent = Workspace

local rainbowColors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 127, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(75, 0, 130),
    Color3.fromRGB(148, 0, 211),
}

local function lerpColor(c1, c2, alpha)
    return c1:Lerp(c2, alpha)
end

local isFlying = true
local antiStuckThread
local rainbowThread
local connection

local function cleanupTrack()
    if trackFolder and trackFolder.Parent then
        trackFolder:Destroy()
    end
end

local function cleanupEverything()
    isFlying = false
    if connection then connection:Disconnect() end
    if rainbowThread then coroutine.close(rainbowThread) end
    if antiStuckThread then coroutine.close(antiStuckThread) end
    cleanupTrack()
end

local function buildLineTrack(points)
    local totalLines = #points - 1
    local delayPerLine = TotalBuildTime / math.max(totalLines, 1)

    for i = 1, totalLines do      
        local fromPos = points[i]      
        local toPos = points[i + 1]      
        local distance = (toPos - fromPos).Magnitude      

        local part = Instance.new("Part")      
        part.Anchored = true      
        part.CanCollide = false      
        part.Material = Enum.Material.Neon      
        part.Color = rainbowColors[1]      
        part.Size = Vector3.new(0.2, 0.2, distance)      
        part.CFrame = CFrame.new(fromPos, toPos) * CFrame.new(0, 0, -distance / 2)      
        part.Transparency = ShowLines and 0.3 or 1      
        part.Parent = trackFolder      

        task.wait(delayPerLine)      
    end
end

local function animateRainbow()
    local parts = trackFolder:GetChildren()
    local colorCount = #rainbowColors
    local timePerTransition = 1

    rainbowThread = coroutine.create(function()      
        local t = 0      
        while isFlying do      
            t += RunService.Heartbeat:Wait()      
            for i, part in ipairs(parts) do      
                if not part:IsDescendantOf(workspace) then continue end      
                local index1 = ((i + math.floor(t / timePerTransition)) % colorCount) + 1      
                local index2 = (index1 % colorCount) + 1      
                local alpha = (t % timePerTransition) / timePerTransition      
                part.Color = lerpColor(rainbowColors[index1], rainbowColors[index2], alpha)      
            end      
        end      
    end)      
    coroutine.resume(rainbowThread)
end

local function startAntiStuckCheck()
    if not AntiStuckEnabled then return end

    antiStuckThread = coroutine.create(function()      
        local lastPosition = root.Position      
        local stuckTimer = 0      
        local spamJumpInterval = 0.1      

        while isFlying do      
            local currentPosition = root.Position      
            local distance = (currentPosition - lastPosition).Magnitude      

            if distance < 0.5 then      
                stuckTimer += spamJumpInterval      
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)      

                if stuckTimer >= 0.5 then      
                    local pushDirection = Vector3.new(      
                        math.random(-1, 1),      
                        1,      
                        math.random(-1, 1)      
                    ).Unit      
                    root.AssemblyLinearVelocity += pushDirection * 25      
                end      
            else      
                stuckTimer = 0      
            end      

            lastPosition = currentPosition      
            task.wait(spamJumpInterval)      
        end      
    end)      

    coroutine.resume(antiStuckThread)
end

local function getClosestPointOnTrack(position)
    local closestDistance = math.huge
    local closestPoint = trackPoints[1]
    local closestIndex = 1

    for i = 1, #trackPoints - 1 do    
        local a = trackPoints[i]    
        local b = trackPoints[i + 1]    
        local ab = b - a    
        local ap = position - a    
        local t = math.clamp(ap:Dot(ab.Unit) / ab.Magnitude, 0, 1)    
        local point = a + ab * t    
        local dist = (position - point).Magnitude    
        if dist < closestDistance then    
            closestDistance = dist    
            closestPoint = point    
            closestIndex = i  
        end    
    end    

    return closestPoint, closestDistance, closestIndex
end

local function showNotification(message)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "⚠ Warning!",
            Text = message,
            Duration = 3
        })
    end)
end

local function flyToPosition(targetPos, targetIndex)
    local reached = false

    connection = RunService.Heartbeat:Connect(function()  
        if not root or not root.Parent or not isFlying then  
            connection:Disconnect()  
            reached = true  
            return  
        end  

        local currentPos = root.Position  
        local direction = targetPos - currentPos  
        local distance = direction.Magnitude  

        local closestPoint, distFromTrack, closestIndex = getClosestPointOnTrack(currentPos)  

        if distFromTrack > OutOfTrackRadius then  
            showNotification("You left the path! Teleporting forward...")  
            local teleportIndex = math.min(closestIndex + 1, #trackPoints)  
            local teleportPos = trackPoints[teleportIndex] + Vector3.new(0, 3, 0)  
            root.CFrame = CFrame.new(teleportPos)  
            root.AssemblyLinearVelocity = Vector3.zero  
            task.wait(0.5)  
            return  
        end  

        if distance < 2 then  
            root.AssemblyLinearVelocity = Vector3.zero  
            connection:Disconnect()  
            reached = true  
            return  
        end  

        local velocity = direction.Unit * Speed  
        root.AssemblyLinearVelocity = velocity  
        root.CFrame = CFrame.lookAt(currentPos, targetPos)  
    end)  

    repeat RunService.Heartbeat:Wait() until reached
end

local function flyAlongTrack(points)
    for i = 1, #points do
        if not isFlying then break end
        local target = points[i]
        if i > 1 then
            local prev = points[i - 1]
            local deltaY = target.Y - prev.Y
            if deltaY > 5 then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                task.wait(0.2)
            end
        end
        flyToPosition(target, i)
    end
    cleanupEverything()
end

spawn(function()
    if ShowLines then
        buildLineTrack(trackPoints)
        animateRainbow()
    end

    startAntiStuckCheck()  
    flyAlongTrack(trackPoints)
end)
