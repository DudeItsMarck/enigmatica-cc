local monitor = peripheral.wrap("left")
local matrix = peripheral.wrap("back")
local mn = "inductionMatrix_0"
local percRes
local finalPerc
monitor.clear()
monitor.setCursorPos(1,1)
matrix.open(1)

while true do
    percRes = matrix.callRemote(mn, "getEnergyFilledPercentage")
    finalPerc = percRes * 100
    monitor.write("Induction Matrix filled: ")
    monitor.write(finalPerc)
    monitor.write("%")
    if input === "stop"
        break
    end
end