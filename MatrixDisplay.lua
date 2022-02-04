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

    percTen = percRes * 28
    formatted = string.format(
        "%.2f%%",
        percRes * 100
     )
    monitor.clear()
    monitor.setCursorPos(8,1)
    monitor.write("Induction Matrix")
    
    monitor.setCursorPos(2,5)
    for i=1,28 do
        if i > percTen then
            monitor.setBackgroundColor(colors.red)
            monitor.write(" ")
        else
            monitor.setBackgroundColor(colors.lime)
            monitor.write(" ")
        end
    end
    
    monitor.setBackgroundColor(colors.black)
    monitor.setCursorPos(13,6)
    monitor.write(formatted)

    monitor.setCursorPos(8,8)
    monitor.write(fCurEnergy)
    monitor.write(" / ")
    monitor.write(fMaxEnergy)
    monitor.write(" TFE")



    -- local event, key = os.pullEvent( "key" ) -- limit os.pullEvent to the 'key' event
  
    -- if key == keys.e then -- if the key pressed was 'e'
    --   print( "You pressed [E]. Exiting program..." )
    --   break
    -- end
end