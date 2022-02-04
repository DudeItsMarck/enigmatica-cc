local monitor = peripheral.wrap("left")
local matrix = peripheral.wrap("back")
local mn = "inductionMatrix_0"
local percRes
local finalPerc

while true do
    monitor.clear()
    monitor.setCursorPos(1,1)

    matrix.open(1)

    local percRes = matrix.callRemote(mn, "getEnergyFilledPercentage")
    local finalPerc = percRes * 100
    monitor.write("Induction Matrix filled: ")
    monitor.write(finalPerc)
    monitor.write("%")
end