local monitor = peripheral.wrap("left")
monitor.clear()
monitor.setCursorPos(1,1)

local matrix = peripheral.wrap("back")
matrix.open(1)

local mn = matrix.getRemoteNames(1)

local percRes = matrix.callRemote(mn, "getEnergyFilledPercentage")
local finalPerc = percRes * 100
monitor.write(finalPerc)