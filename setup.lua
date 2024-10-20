-- Paste this into OpenComputer terminal to download and set up your program
-- wget https://raw.githubusercontent.com/YamiNoKanata/Personal-GTNH-Programm-for-OpenComputers/master/setup.lua -f

local shell = require("shell")
local filesystem = require("filesystem")
local computer = require("computer")
local component = require("component")
local gpu = component.gpu
local width, height = gpu.getResolution()

local colorA = 0x00A6FF
local colorB = 0xFF00FF

gpu.fill(1, 1, width, height, " ")
gpu.setForeground(0x181818)
gpu.fill(width / 2 - 11, height / 2 - 3, 23, 6, "▄")
gpu.fill(width / 2 - 10, height / 2 - 2, 21, 4, " ")
gpu.setForeground(colorA)
gpu.set(width / 2 - 5, height / 2 - 2, "Updating Program")

local programURL = "https://github.com/YamiNoKanata/Personal-GTNH-Programm-for-OpenComputers/archive/refs/heads/master.zip"

-- Funktion zum Herunterladen und Entpacken
local function downloadAndExtract(url, targetDir)
    shell.setWorkingDirectory("/tmp")
    shell.execute("wget -fq " .. url)
    shell.execute("unzip -q master.zip")
    shell.execute("mv Personal-GTNH-Programm-for-OpenComputers-master/* " .. targetDir)
    shell.execute("rm -rf Personal-GTNH-Programm-for-OpenComputers-master master.zip")
end

local successful =
    pcall(
    function()
        local workDir = "/home/GTNH-Program/"
        
        -- Erstelle das Zielverzeichnis
        filesystem.makeDirectory(workDir)

        gpu.set(width / 2 - 5, height / 2 - 1, "Downloading . . .")
        downloadAndExtract(programURL, workDir)
        gpu.set(width / 2 - 5, height / 2 - 1, "                 ")
        
        gpu.set(width / 2 - 5, height / 2, "Update complete.  ")
        gpu.setForeground(colorB)
        gpu.set(width / 2 - 5, height / 2 + 1, "Rebooting  ")
        os.sleep(1)
        computer.shutdown(true)
    end
)

if (not successful) then
    gpu.setForeground(0xFF0000)
    gpu.set(width / 2 - 5, height / 2, "Update failed!  ")
end
