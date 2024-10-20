local turbineControl = {}

local enabled = true
local disabled = false

-- Adresse der Turbinen
local turbine4
local turbine3
local turbine2
local turbine1

function turbineControl.init(turbines)
    turbine4 = turbines.turbine4
    turbine3 = turbines.turbine3
    turbine2 = turbines.turbine2
    turbine1 = turbines.turbine1
end

local function updateTurbineStatus()
    local statusText = {}
    if turbine4.getInfo().workAllowed then table.insert(statusText, "4: ON") else table.insert(statusText, "4: OFF") end
    if turbine3.getInfo().workAllowed then table.insert(statusText, "3: ON") else table.insert(statusText, "3: OFF") end
    if turbine2.getInfo().workAllowed then table.insert(statusText, "2: ON") else table.insert(statusText, "2: OFF") end
    if turbine1.getInfo().workAllowed then table.insert(statusText, "1: ON") else table.insert(statusText, "1: OFF") end
    energyDisplay.turbineStatus = "Turbine Status: " .. table.concat(statusText, ", ")
end

function turbineControl.manageTurbines(currentEnergy)
    if currentEnergy > maxEnergy then
        turbineControl.turbineOff()
    elseif currentEnergy < minEnergy then
        turbineControl.turbineOn()
    end
    updateTurbineStatus()
end

function turbineControl.turbineOn()        
    turbine4.setWorkAllowed(enabled)
    turbine3.setWorkAllowed(enabled)
    turbine2.setWorkAllowed(enabled)
    turbine1.setWorkAllowed(enabled)
end

function turbineControl.turbineOff()        
    turbine4.setWorkAllowed(disabled)
    turbine3.setWorkAllowed(disabled)
    turbine2.setWorkAllowed(disabled)
    turbine1.setWorkAllowed(disabled)
end

return turbineControl
