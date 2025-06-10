local Speed = 105
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
 Vector3.new(148.50, 238.00, 962.50),
Vector3.new(153.22, 243.77, 970.04),
Vector3.new(162.08, 255.08, 983.03),
Vector3.new(171.30, 269.55, 996.02),
Vector3.new(175.80, 264.84, 1002.22),
Vector3.new(178.72, 265.00, 1004.69),
Vector3.new(173.33, 269.27, 1004.92),
Vector3.new(157.23, 283.98, 1006.20),
Vector3.new(142.88, 296.24, 1007.59),
Vector3.new(130.75, 291.90, 1008.61),
Vector3.new(124.65, 291.90, 1008.33),
Vector3.new(110.16, 308.39, 1007.84),
Vector3.new(93.22, 319.43, 1005.27),
Vector3.new(72.73, 332.24, 1003.68),
Vector3.new(54.57, 328.50, 1004.58),
Vector3.new(36.67, 305.01, 1006.10),
Vector3.new(19.41, 280.73, 1006.52),
Vector3.new(3.47, 295.61, 1006.73),
Vector3.new(-14.63, 302.07, 1007.42),
Vector3.new(-32.78, 295.68, 1008.16),
Vector3.new(-51.67, 269.23, 1008.92),
Vector3.new(-67.74, 257.01, 1009.49),
Vector3.new(-83.74, 257.00, 1010.93),
Vector3.new(-100.32, 257.00, 1012.52),
Vector3.new(-118.57, 257.00, 1014.26),
Vector3.new(-137.49, 252.99, 1014.91),
Vector3.new(-155.30, 252.40, 1016.47),
Vector3.new(-175.28, 251.98, 1015.84),
Vector3.new(-204.54, 252.00, 1015.54),
Vector3.new(-242.05, 252.03, 1018.52),
Vector3.new(-280.11, 253.60, 1022.79),
Vector3.new(-318.06, 272.76, 1027.86),
Vector3.new(-362.65, 304.34, 1035.38),
Vector3.new(-404.80, 310.48, 1044.61),
Vector3.new(-445.18, 292.39, 1059.74),
Vector3.new(-477.84, 254.65, 1082.93),
Vector3.new(-502.65, 267.53, 1111.94),
Vector3.new(-530.21, 293.54, 1137.41),
Vector3.new(-563.88, 300.25, 1155.58),
Vector3.new(-596.64, 310.61, 1165.86),
Vector3.new(-629.87, 310.72, 1171.12),
Vector3.new(-654.40, 326.54, 1173.02),
Vector3.new(-673.91, 331.06, 1176.66),
Vector3.new(-701.33, 331.02, 1181.00),
Vector3.new(-717.76, 345.15, 1182.94),
Vector3.new(-735.01, 352.20, 1192.83),
Vector3.new(-753.95, 339.30, 1203.51),
Vector3.new(-774.37, 325.00, 1207.00),
Vector3.new(-795.84, 325.00, 1206.18),
Vector3.new(-818.36, 320.71, 1206.55),
Vector3.new(-832.70, 321.02, 1205.96),
Vector3.new(-855.14, 321.04, 1191.82),
Vector3.new(-857.70, 325.08, 1190.13),
Vector3.new(-852.52, 320.03, 1197.98),
Vector3.new(-851.66, 321.17, 1200.56),
Vector3.new(-858.07, 320.99, 1198.02),
Vector3.new(-870.99, 320.99, 1190.48),
Vector3.new(-883.87, 321.00, 1174.25),
Vector3.new(-883.88, 321.08, 1148.04),
Vector3.new(-866.35, 321.03, 1120.06),
Vector3.new(-856.08, 321.05, 1087.51),
Vector3.new(-877.04, 321.00, 1052.24),
Vector3.new(-893.07, 327.89, 1013.58),
Vector3.new(-906.63, 359.97, 973.51),
Vector3.new(-917.64, 370.82, 943.66),
Vector3.new(-930.72, 382.51, 917.29),
Vector3.new(-939.60, 390.60, 897.22),
Vector3.new(-948.30, 392.10, 875.21),
Vector3.new(-950.41, 405.60, 872.33),
Vector3.new(-957.52, 398.60, 860.50),
Vector3.new(-975.15, 397.59, 866.58),
Vector3.new(-993.17, 405.50, 879.54),
Vector3.new(-1002.56, 420.67, 897.09),
Vector3.new(-1011.55, 430.94, 917.72),
Vector3.new(-1018.16, 434.07, 936.06),
Vector3.new(-1025.04, 437.90, 955.43),
Vector3.new(-1037.70, 453.57, 973.50),
Vector3.new(-1050.02, 461.00, 991.24),
Vector3.new(-1053.68, 451.78, 1010.98),
Vector3.new(-1049.89, 451.93, 1032.48),
Vector3.new(-1044.06, 460.51, 1053.04),
Vector3.new(-1042.81, 454.53, 1076.04),
Vector3.new(-1039.95, 469.16, 1096.39),
Vector3.new(-1036.64, 473.52, 1118.47),
Vector3.new(-1033.92, 473.18, 1139.53),
Vector3.new(-1036.11, 467.99, 1162.19),
Vector3.new(-1039.41, 468.00, 1184.05),
Vector3.new(-1041.86, 468.00, 1205.76),
Vector3.new(-1046.18, 477.42, 1228.91),
Vector3.new(-1049.96, 465.27, 1251.33),
Vector3.new(-1053.49, 477.41, 1273.19),
Vector3.new(-1058.01, 490.36, 1293.69),
Vector3.new(-1067.16, 495.74, 1315.34),
Vector3.new(-1077.54, 476.77, 1337.79),
Vector3.new(-1084.41, 477.84, 1359.48),
Vector3.new(-1089.13, 488.26, 1383.40),
Vector3.new(-1091.22, 478.08, 1405.21),
Vector3.new(-1090.33, 490.27, 1428.44),
Vector3.new(-1090.01, 492.30, 1449.07),
Vector3.new(-1089.91, 476.17, 1469.72),
Vector3.new(-1079.62, 469.02, 1485.04),
Vector3.new(-1062.35, 479.06, 1495.79),
Vector3.new(-1043.97, 496.44, 1509.62),
Vector3.new(-1027.65, 502.41, 1522.38),
Vector3.new(-1008.50, 495.99, 1524.25),
Vector3.new(-988.40, 505.03, 1511.71),
Vector3.new(-966.87, 519.27, 1502.22),
Vector3.new(-947.24, 527.38, 1493.75),
Vector3.new(-924.27, 512.90, 1484.05),
Vector3.new(-905.85, 508.00, 1475.49),
Vector3.new(-883.62, 507.48, 1479.52),
Vector3.new(-867.50, 504.97, 1478.67),
Vector3.new(-847.74, 505.02, 1485.26),
Vector3.new(-816.72, 505.03, 1495.94),
Vector3.new(-783.39, 517.76, 1504.86),
Vector3.new(-748.53, 548.91, 1516.92),
Vector3.new(-711.21, 567.41, 1527.18),
Vector3.new(-680.46, 573.92, 1530.93),
Vector3.new(-651.92, 589.70, 1529.27),
Vector3.new(-628.75, 597.21, 1526.05),
Vector3.new(-606.83, 583.71, 1520.05),
Vector3.new(-587.79, 592.47, 1516.47),
Vector3.new(-568.98, 588.69, 1512.04),
Vector3.new(-546.84, 599.97, 1507.33),
Vector3.new(-526.53, 593.83, 1504.63),
Vector3.new(-504.51, 583.00, 1505.37),
Vector3.new(-484.86, 592.06, 1512.79),
Vector3.new(-467.90, 607.51, 1523.85),
Vector3.new(-454.76, 614.85, 1538.57),
Vector3.new(-441.08, 619.46, 1550.74),
Vector3.new(-449.04, 636.62, 1554.97),
Vector3.new(-470.93, 643.76, 1559.31),
Vector3.new(-488.41, 640.98, 1551.13),
Vector3.new(-497.91, 641.00, 1533.65),
Vector3.new(-501.23, 649.97, 1512.39),
Vector3.new(-500.34, 649.57, 1488.63),
Vector3.new(-497.92, 658.05, 1467.87),
Vector3.new(-499.33, 650.89, 1447.05),
Vector3.new(-521.04, 656.22, 1438.59),
Vector3.new(-544.29, 658.10, 1436.13),
Vector3.new(-564.95, 654.68, 1435.36),
Vector3.new(-587.70, 669.45, 1434.13),
Vector3.new(-609.07, 664.38, 1431.06),
Vector3.new(-630.47, 659.64, 1426.56),
Vector3.new(-651.88, 667.10, 1422.89),
Vector3.new(-673.04, 658.87, 1420.10),
Vector3.new(-693.95, 631.98, 1416.97),
Vector3.new(-716.03, 623.10, 1411.90),
Vector3.new(-736.61, 633.16, 1407.79),
Vector3.new(-758.00, 635.92, 1404.15),
Vector3.new(-780.12, 618.30, 1401.66),
Vector3.new(-802.64, 633.17, 1404.01),
Vector3.new(-825.35, 636.71, 1404.61),
Vector3.new(-848.86, 636.32, 1405.32),
Vector3.new(-869.64, 625.99, 1405.46),
Vector3.new(-890.43, 626.00, 1409.51),
Vector3.new(-913.63, 633.02, 1414.32),
Vector3.new(-937.14, 623.95, 1420.18),
Vector3.new(-958.55, 595.05, 1423.89),
Vector3.new(-979.57, 605.08, 1428.44),
Vector3.new(-1000.17, 607.28, 1434.98),
Vector3.new(-1022.45, 614.73, 1440.33),
Vector3.new(-1045.91, 626.23, 1447.21),
Vector3.new(-1065.39, 615.15, 1457.26),
Vector3.new(-1082.46, 610.17, 1469.81),
Vector3.new(-1098.47, 620.91, 1482.89),
Vector3.new(-1114.74, 623.46, 1496.65),
Vector3.new(-1131.33, 620.27, 1511.75),
Vector3.new(-1148.93, 601.88, 1525.76),
Vector3.new(-1170.03, 610.69, 1526.75),
Vector3.new(-1192.37, 628.59, 1527.10),
Vector3.new(-1215.32, 631.11, 1527.91),
Vector3.new(-1229.48, 632.73, 1527.67),
Vector3.new(-1221.64, 650.04, 1527.24),
Vector3.new(-1219.87, 666.31, 1533.17),
Vector3.new(-1218.87, 667.92, 1546.39),
Vector3.new(-1217.68, 668.00, 1562.69),
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
