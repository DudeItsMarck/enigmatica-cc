-- github clone DudeItsMarck/enigmatica-cc
-- enigmatica-cc/MatrixDisplay.lua

local monitor = peripheral.wrap("left")
local matrix = peripheral.wrap("inductionPort_0")
local modem = peripheral.wrap("bottom")
local mn = ""
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
    percRes = matrix.getEnergyFilledPercentage()

    lastIn = matrix.getLastInput() / 2.5
    fLastIn = string.format(
        "%.2f",
        lastIn / 1000
    )
    
    lastOut = matrix.getLastOutput() / 2.5
    fLastOut = string.format(
        "%.2f",
        lastOut / 1000
    )

    maxEnergy = matrix.getMaxEnergy() / 2.5 / 1000000000000
    fMaxEnergy = string.format(
        "%.3f",
        maxEnergy
    )
    
    curEnergy = matrix.getEnergy() / 2.5 / 1000000000000
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
    monitor.write("Input:  " .. fLastIn .. " kFE/t")

    monitor.setCursorPos(6, 4)
    monitor.write("Output: " .. fLastOut .. " kFE/t")
    
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
    monitor.write(fCurEnergy .. " / " .. fMaxEnergy .. " TFE")

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