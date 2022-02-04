-- github clone DudeItsMarck/enigmatica-cc
-- enigmatica-cc/MatrixDisplay.lua

local monitor = peripheral.wrap("left")
local matrix = peripheral.wrap("back")
local mn = "inductionMatrix_0"
local percRes
local formatted
local event = os.pullEventRaw()
matrix.open(1)

while true do
    percRes = matrix.callRemote(mn, "getEnergyFilledPercentage")
    percTen = percRes * 10
    formatted = string.format(
        "%.2f%%",
        percRes * 100
     )
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write("Induction Matrix filled: ")
    monitor.write(formatted)

    monitor.setCursorPos(1,2)
    for i=1,10 do
        if i > percTen then
            monitor.setBackgroundColor(color.black)
            monitor.write("\127")
        else
            monitor.setBackgroundColor(color.white)
            monitor.write(" ")
        end
    end

    monitor.setBackgroundColor(color.black)


    local event, key = os.pullEvent( "key" ) -- limit os.pullEvent to the 'key' event
  
    if key == keys.e then -- if the key pressed was 'e'
      print( "You pressed [E]. Exiting program..." )
      break
    end
end