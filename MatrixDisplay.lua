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
    formatted = string.format(
        "%.2f %%",
        percRes * 100
     )
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write("Induction Matrix filled: ")
    monitor.write(finalPerc)
    monitor.write("%")

    local event, key = os.pullEvent( "key" ) -- limit os.pullEvent to the 'key' event
  
    if key == keys.e then -- if the key pressed was 'e'
      print( "You pressed [E]. Exiting program..." )
      break
    end
end