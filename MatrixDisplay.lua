-- github clone DudeItsMarck/enigmatica-cc
-- enigmatica-cc/MatrixDisplay.lua

local monitor = peripheral.wrap("left")
local matrix = peripheral.wrap("back")
local mn = "inductionMatrix_0"
local percRes, maxEnergy, curEnergy
local formatted
local event = os.pullEventRaw()
matrix.open(1)
monitor.clear()
monitor.setTextScale(2)

while true do
    percRes = matrix.callRemote(mn, "getEnergyFilledPercentage")
    -- maxEnergy = string.format(
    --     "%.2f",
    --     matrix.callRemote(mn, "getMaxEnergy") / 1000000000
    --  )
    maxEnergy = matrix.callRemote(mn, "getMaxEnergy") / 1000000000000
    fMaxEnergy = string.format(
        "%.2f",
        maxEnergy
    )
    
    -- curEnergy = string.format(
    --     "%.2f",
    --     matrix.callRemote(mn, "getEnergy") / 1000000000
    --  )
    curEnergy = matrix.callRemote(mn, "getEnergy") / 1000000000000
    fCurEnergy = string.format(
        "%.2f",
        curEnergy
    )

    percTen = percRes * 21
    formatted = string.format(
        "%.2f%%",
        percRes * 100
     )
    monitor.clear()
    monitor.setCursorPos(4,5)
    monitor.write("Induction Matrix filled: ")
    
    monitor.setCursorPos(2,6)
    for i=1,21 do
        if i > percTen then
            monitor.setBackgroundColor(colors.red)
            monitor.write("\127")
        else
            monitor.setBackgroundColor(colors.lime)
            monitor.write(" ")
        end
    end
    
    monitor.setBackgroundColor(colors.black)
    monitor.write(" ")
    monitor.write(formatted)

    monitor.setCursorPos(5,7)
    monitor.write(fCurEnergy)
    monitor.write(" / ")
    monitor.write(fMaxEnergy)



    -- local event, key = os.pullEvent( "key" ) -- limit os.pullEvent to the 'key' event
  
    -- if key == keys.e then -- if the key pressed was 'e'
    --   print( "You pressed [E]. Exiting program..." )
    --   break
    -- end
end