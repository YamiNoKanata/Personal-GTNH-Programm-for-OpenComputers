local comp = require("component")
local gpu = comp.gpu

-- Komponenten laden
local capacitor = comp.proxy("cc902a00-bacc-463f-8e5e-e6a2b1ad80ba")
local turbine4 = comp.proxy("130050c5-c6b5-47dc-9c4c-d0794c4fc0d1")
local turbine3 = comp.proxy("11369719-2f32-4010-9594-183901710d29")
local turbine2 = comp.proxy("fef136ad-b83e-436d-ace3-632fa9f2f3d9")
local turbine1 = comp.proxy("8d60e59c-676d-4555-a0ae-1ac8ea74fa5b")

-- Maximale Auflösung festlegen
local newWidth, newHeight = 80, 20
gpu.setResolution(newWidth, newHeight)

-- Module importieren
local energyDisplay = require("energyDisplay")
local turbineControl = require("turbineControl")

-- Hauptloop
while true do
    energyDisplay.updateVariables(capacitor)  -- Variablen aktualisieren
    turbineControl.manageTurbines(currentEnergy)  -- Turbinensteuerung basierend auf Energielevel
    energyDisplay.updateScreen(gpu, newWidth)  -- Bildschirm aktualisieren
end
