local energyDisplay = {}

-- Variableninitialisierung
local currentEnergy, maxEnergyCapacity, energyInput, energyOutput
local maxEnergy, minEnergy
local turbineStatus = "Turbine Status: [Unavailable]"

-- Maximale Energiespeicher
local function initializeEnergyLimits(capacitor)
    maxEnergyCapacity = capacitor.getEUCapacity()
    maxEnergy = maxEnergyCapacity * 0.97  -- 97% von max Energie Capacity (Turbinen ausschalten)
    minEnergy = maxEnergyCapacity * 0.10  -- 10% von max Energie Capacity (Turbinen einschalten)
end

function energyDisplay.updateVariables(capacitor)
    if not maxEnergyCapacity then
        initializeEnergyLimits(capacitor)
    end
    currentEnergy = capacitor.getEUStored()
    energyInput = capacitor.getEUInputAverage()
    energyOutput = capacitor.getEUOutputAverage()
end

-- Funktion zum Text zentrieren
local function centeredText(gpu, y, text, newWidth)
    gpu.set((newWidth / 2) - (#text / 2), y, text)
end

function energyDisplay.updateScreen(gpu, newWidth)
    gpu.fill(1, 1, newWidth, 20, " ")  -- Höhe auf 20 anpassen
    
    centeredText(gpu, 6, "Energy: " .. currentEnergy .. " / " .. maxEnergyCapacity, newWidth)
    centeredText(gpu, 7, "Energy Input: " .. (energyInput > 0 and energyInput or 0), newWidth)
    centeredText(gpu, 8, "Energy Output: " .. (energyOutput > 0 and energyOutput or 0), newWidth)
    
    centeredText(gpu, 9, turbineStatus, newWidth)
end

return energyDisplay
