-- github clone DudeItsMarck/enigmatica-cc
-- enigmatica-cc/MatrixDisplay.lua

local arc = peripheral.wrap("right")
local matrix = peripheral.wrap("top")
local mn = "inductionMatrix_0"
local percRes, maxEnergy, curEnergy, lastIn, lastOut
local formatted
local event = os.pullEventRaw()
matrix.open(1)
arc.clear()
arc.setRelativeMode(true, 60, 20)


while true do
    percRes = matrix.callRemote(mn, "getEnergyFilledPercentage")

    lastIn = matrix.callRemote(mn, "getLastInput")
    fLastIn = string.format(
        "%.2f",
        lastIn / 1000
    )
    
    lastOut = matrix.callRemote(mn, "getLastOutput")
    fLastOut = string.format(
        "%.2f",
        lastOut / 1000
    )

    maxEnergy = matrix.callRemote(mn, "getMaxEnergy") / 1000000000000
    fMaxEnergy = string.format(
        "%.3f",
        maxEnergy
    )
    
    curEnergy = matrix.callRemote(mn, "getEnergy") / 1000000000000
    fCurEnergy = string.format(
        "%.3f",
        curEnergy
    )

    percBar = string.format(
        "%.0f",
        percRes * 100
    )

    fPercRes = string.format(
        "%.2f%%",
        percRes * 100
     )

    arc.clear()
    arc.drawString("Induction Matrix", 8, 1, 0xFFFFFF)

    arc.drawString("Input:  " .. tostring(fLastIn) .. " kFE/t", 6, 3, 0xFFFFFF)

    arc.drawString("Output: " .. tostring(fLastOut) .. " kFE/t", 6, 4, 0xFFFFFF)
    
    arc.drawString(fPercRes, 13, 6, 0xFFFFFF)
    
    -- monitor.setCursorPos(2,7)
    -- for i=1,100 do
    --     if i <= tonumber(percBar) then
    --         monitor.setBackgroundColor(colors.lime)
    --         monitor.write(" ")
    --     else
    --         monitor.setBackgroundColor(colors.red)
    --         monitor.write(" ")
    --         print(i)
    --     end
    -- end    

    -- monitor.setBackgroundColor(colors.black)

    arc.drawString(fCurEnergy .. " / " .. fMaxEnergy .. " TFE", 8, 10, 0xFFFFFF)



    -- local event, key = os.pullEvent( "key" ) -- limit os.pullEvent to the 'key' event
  
    -- if key == keys.e then -- if the key pressed was 'e'
    --   print( "You pressed [E]. Exiting program..." )
    --   break
    -- end
end