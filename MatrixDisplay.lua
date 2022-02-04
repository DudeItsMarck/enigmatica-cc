-- github clone DudeItsMarck/enigmatica-cc
-- enigmatica-cc/MatrixDisplay.lua

local monitor = peripheral.wrap("left")
local matrix = peripheral.wrap("back")
local mn = "inductionMatrix_0"
local percRes
local formatted
local event = os.pullEventRaw()
matrix.open(1)
monitor.clear()
monitor.setTextScale(2)

while true do
    percRes = matrix.callRemote(mn, "getEnergyFilledPercentage")
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


    local event, key = os.pullEvent( "key" ) -- limit os.pullEvent to the 'key' event
  
    if key == keys.e then -- if the key pressed was 'e'
      print( "You pressed [E]. Exiting program..." )
      break
    end
end