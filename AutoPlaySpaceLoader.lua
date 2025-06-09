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
    Vector3.new(11.50, 11.00, 18.50),
Vector3.new(13.47, 11.00, 10.65),
Vector3.new(17.22, 11.00, -14.22),
Vector3.new(13.88, 11.00, -40.12),
Vector3.new(11.60, 21.34, -70.49),
Vector3.new(16.43, 25.10, -99.98),
Vector3.new(23.08, 35.15, -127.29),
Vector3.new(35.45, 40.70, -153.29),
Vector3.new(52.71, 29.29, -178.24),
Vector3.new(77.12, 49.17, -196.33),
Vector3.new(100.74, 47.99, -195.60),
Vector3.new(124.60, 56.95, -179.76),
Vector3.new(149.82, 66.42, -166.85),
Vector3.new(174.69, 69.80, -153.55),
Vector3.new(183.18, 80.63, -128.50),
Vector3.new(192.18, 88.06, -103.25),
Vector3.new(194.31, 101.71, -72.86),
Vector3.new(191.09, 98.85, -43.51),
Vector3.new(195.12, 90.49, -14.92),
Vector3.new(190.33, 90.50, 13.51),
Vector3.new(186.35, 109.19, 43.96),
Vector3.new(179.55, 113.47, 79.47),
Vector3.new(174.71, 127.55, 109.91),
Vector3.new(165.13, 132.53, 144.56),
Vector3.new(147.38, 136.28, 179.46),
Vector3.new(119.19, 150.06, 211.48),
Vector3.new(84.19, 182.50, 214.03),
Vector3.new(50.43, 215.89, 216.94),
Vector3.new(8.37, 243.94, 204.57),
Vector3.new(-27.56, 241.27, 164.42),
Vector3.new(-38.67, 240.22, 111.98),
Vector3.new(-44.21, 270.80, 57.97),
Vector3.new(-46.38, 283.57, 24.39),
Vector3.new(-45.00, 281.23, -4.82),
Vector3.new(-41.99, 274.28, -34.14),
Vector3.new(-37.02, 259.11, -59.91),
Vector3.new(-31.68, 259.11, -88.32),
Vector3.new(-26.55, 267.64, -116.93),
Vector3.new(-20.62, 274.79, -146.49),
Vector3.new(-13.22, 281.43, -173.57),
Vector3.new(-4.72, 283.91, -202.70),
Vector3.new(9.48, 285.31, -225.60),
Vector3.new(29.03, 301.85, -245.72),
Vector3.new(48.82, 301.88, -265.78),
Vector3.new(69.22, 283.10, -285.39),
Vector3.new(90.06, 283.11, -305.14),
Vector3.new(114.04, 292.07, -323.17),
Vector3.new(137.16, 287.49, -340.42),
Vector3.new(160.10, 310.50, -357.66),
Vector3.new(183.67, 331.14, -373.93),
Vector3.new(207.72, 331.46, -388.99),
Vector3.new(236.82, 322.86, -400.91),
Vector3.new(263.79, 344.01, -409.73),
Vector3.new(276.23, 360.35, -413.33),
Vector3.new(297.63, 357.47, -420.23),
Vector3.new(323.87, 355.19, -428.70),
Vector3.new(349.09, 357.98, -437.72),
Vector3.new(374.35, 373.73, -450.19),
Vector3.new(403.63, 381.56, -463.21),
Vector3.new(402.60, 400.74, -453.38),
Vector3.new(388.08, 420.35, -447.35),
Vector3.new(372.05, 424.04, -440.16),
Vector3.new(347.63, 437.43, -431.37),
Vector3.new(320.43, 437.45, -423.46),
Vector3.new(293.86, 413.01, -413.44),
Vector3.new(275.54, 420.88, -395.03),
Vector3.new(270.09, 436.70, -369.23),
Vector3.new(269.05, 446.92, -342.95),
Vector3.new(286.02, 440.10, -324.21),
Vector3.new(313.62, 448.69, -317.31),
Vector3.new(340.86, 458.56, -311.72),
Vector3.new(363.25, 475.01, -319.30),
Vector3.new(376.07, 474.94, -346.16),
Vector3.new(386.89, 495.00, -369.75),
Vector3.new(376.84, 497.36, -389.17),
Vector3.new(352.97, 513.30, -404.68),
Vector3.new(330.81, 533.07, -420.51),
Vector3.new(306.47, 541.24, -431.13),
Vector3.new(287.85, 555.29, -418.28),
Vector3.new(287.04, 572.00, -390.49),
Vector3.new(303.45, 566.11, -370.73),
Vector3.new(322.98, 568.10, -351.79),
Vector3.new(338.42, 576.20, -325.96),
Vector3.new(364.38, 588.05, -297.54),
Vector3.new(377.95, 591.38, -267.68),
Vector3.new(392.09, 593.51, -234.40),
Vector3.new(398.26, 597.61, -195.60),
Vector3.new(386.48, 611.75, -152.51),
Vector3.new(356.80, 615.64, -121.00),
Vector3.new(308.93, 606.48, -111.59),
Vector3.new(265.09, 586.96, -119.47),
Vector3.new(222.16, 559.52, -130.12),
Vector3.new(191.31, 520.50, -150.85),
Vector3.new(153.62, 487.28, -177.09),
Vector3.new(102.29, 486.72, -214.86),
Vector3.new(62.06, 523.09, -249.49),
Vector3.new(34.56, 541.37, -274.60),
Vector3.new(15.78, 524.65, -298.35),
Vector3.new(-2.08, 522.30, -320.58),
Vector3.new(-21.91, 506.68, -341.12),
Vector3.new(-43.45, 492.22, -355.12),
Vector3.new(-65.13, 492.23, -335.37),
Vector3.new(-87.46, 498.30, -314.95),
Vector3.new(-107.55, 516.06, -292.95),
Vector3.new(-128.58, 525.43, -271.90),
Vector3.new(-148.92, 528.23, -251.99),
Vector3.new(-172.09, 511.27, -234.61),
Vector3.new(-189.37, 511.23, -211.77),
Vector3.new(-207.41, 519.76, -188.61),
Vector3.new(-224.51, 501.75, -164.13),
Vector3.new(-238.87, 525.04, -140.37),
Vector3.new(-247.57, 529.76, -113.47),
Vector3.new(-258.73, 512.35, -87.83),
Vector3.new(-268.77, 528.99, -60.59),
Vector3.new(-273.88, 514.60, -31.35),
Vector3.new(-274.29, 521.07, -0.50),
Vector3.new(-274.51, 529.44, 27.42),
Vector3.new(-268.49, 531.10, 62.24),
Vector3.new(-257.66, 539.10, 93.97),
Vector3.new(-245.83, 544.09, 126.79),
Vector3.new(-234.66, 540.19, 165.80),
Vector3.new(-223.05, 513.49, 199.38),
Vector3.new(-213.99, 479.36, 224.51),
Vector3.new(-200.12, 451.74, 259.92),
Vector3.new(-178.68, 439.35, 307.23),
Vector3.new(-158.39, 449.10, 348.84),
Vector3.new(-146.84, 458.79, 375.46),
Vector3.new(-134.03, 449.30, 400.75),
Vector3.new(-117.66, 421.49, 424.20),
Vector3.new(-100.47, 421.49, 444.86),
Vector3.new(-82.62, 421.49, 466.19),
Vector3.new(-65.12, 430.11, 492.22),
Vector3.new(-47.31, 418.14, 514.36),
Vector3.new(-28.15, 436.22, 535.26),
Vector3.new(-6.67, 443.64, 553.97),
Vector3.new(18.51, 429.21, 564.03),
Vector3.new(45.56, 421.24, 571.20),
Vector3.new(72.50, 435.44, 579.32),
Vector3.new(100.17, 429.45, 586.57),
Vector3.new(126.34, 415.49, 592.04),
Vector3.new(151.34, 434.99, 595.65),
Vector3.new(135.11, 467.19, 596.07),
Vector3.new(115.78, 491.55, 596.43),
Vector3.new(105.21, 499.19, 588.83),
Vector3.new(83.18, 494.49, 573.60),
Vector3.new(55.45, 504.42, 566.92),
Vector3.new(26.22, 512.60, 556.28),
Vector3.new(0.25, 523.67, 546.19),
Vector3.new(-24.21, 509.46, 533.52),
Vector3.new(-40.31, 529.97, 511.97),
Vector3.new(-65.41, 527.39, 481.83),
Vector3.new(-70.48, 523.26, 449.27),
Vector3.new(-72.61, 517.05, 414.12),
Vector3.new(-69.86, 504.93, 378.18),
Vector3.new(-61.62, 489.71, 340.55),
Vector3.new(-36.45, 486.52, 299.44),
Vector3.new(-2.25, 491.21, 262.76),
Vector3.new(22.49, 498.96, 222.81),
Vector3.new(26.51, 513.16, 174.38),
Vector3.new(17.18, 539.88, 128.22),
Vector3.new(23.15, 574.61, 82.12),
Vector3.new(63.40, 611.64, 61.06),
Vector3.new(105.20, 652.53, 75.39),
Vector3.new(133.61, 705.36, 99.99),
Vector3.new(154.78, 744.77, 121.39),
Vector3.new(176.30, 751.03, 137.94),
Vector3.new(190.76, 738.12, 160.33),
Vector3.new(208.98, 738.13, 184.12),
Vector3.new(227.09, 738.13, 207.79),
Vector3.new(252.66, 748.35, 227.17),
Vector3.new(276.85, 759.15, 240.37),
Vector3.new(302.83, 770.85, 254.60),
Vector3.new(328.68, 766.05, 266.37),
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
