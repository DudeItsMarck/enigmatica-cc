-- github clone DudeItsMarck/enigmatica-cc
-- enigmatica-cc/MatrixDisplay.lua

local monitor = peripheral.wrap("left")
local matrix = peripheral.wrap("back")
local modem = peripheral.wrap("bottom")
local mn = "inductionMatrix_0"
local percRes, maxEnergy, curEnergy, lastIn, lastOut
local formatted
local event = os.pullEventRaw()
local reactorOn = false
local minPercent = 10
local maxPercent = 99
matrix.open(1)
modem.open(665)
monitor.clear()
monitor.setTextScale(2)

print("Reactor will turn on when the Induction Matrix capacity gets below " .. minPercent .. "%")
print("And off when capacity gets above " .. maxPercent .. "%")

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

    percTen = string.format(
        "%.0f",
        percRes * 28
    )

    fPercRes = string.format(
        "%.2f",
        percRes * 100
    )

    monitor.clear()
    monitor.setCursorPos(8,1)
    monitor.write("Induction Matrix")

    monitor.setCursorPos(6, 3)
    monitor.write("Input:  ")
    monitor.write(fLastIn)
    monitor.write(" kFE/t")

    monitor.setCursorPos(6, 4)
    monitor.write("Output: ")
    monitor.write(fLastOut)
    monitor.write(" kFE/t")
    
    monitor.setCursorPos(13,6)
    monitor.write(fPercRes .. "%")
    
    monitor.setCursorPos(2,7)
    for i=1,28 do
        if i <= tonumber(percTen) then
            monitor.setBackgroundColor(colors.lime)
            monitor.write(" ")
        else
            monitor.setBackgroundColor(colors.red)
            monitor.write(" ")
        end
    end    

    monitor.setBackgroundColor(colors.black)

    monitor.setCursorPos(8,10)
    monitor.write(fCurEnergy)
    monitor.write(" / ")
    monitor.write(fMaxEnergy)
    monitor.write(" TFE")

    if tonumber(fPercRes) < minPercent and reactorOn == false then
        modem.transmit(666, 665, "rsOn")
        reactorOn = true
        print("Reactor On")
    end
    if tonumber(fPercRes) > maxPercent and reactorOn == true then
        modem.transmit(666, 665, "rsOff")
        reactorOn = false
        print("Reactor Off")
    end
end