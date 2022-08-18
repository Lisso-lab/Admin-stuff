local commands = {
    "noclip.lua",
    "antifling.lua",
    "vectorfly.lua"
    "vectorflyspeed.lua"
}

local url = "https://raw.githubusercontent.com/Lisso-lab/Admin-stuff/main/"

local signats = loadstring(game:HttpGet(url .. "signatures.lua"))()

url = url .. "soadmin/"

local function load_url(str: string)
    return game:HttpGet(url .. str)
end

makefolder("/soadmin")
makefolder("/soadmin/commands")

writefile("/soadmin/main.lib", load_url("main.lib"))

writefile("/soadmin/settings.json", "") --TODO :SOB:

for i=1,#commands do
    writefile("/soadmin/commands/" .. commands[i], load_url("commands/" .. commands[i]))

    signats.make_signature("/soadmin/commands/" .. commands[i])
end

signats.make_signature("/soadmin/main.lib")

signats.make_signature("/soadmin/settings.json")
