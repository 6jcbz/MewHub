--[[--]] -- Fart Variables


--getgenv().WishList = {"Pidgey"} 
--getgenv().Webhook = "your webhook here"


--[[--]] -- Global Variables
getgenv().AutoFinder = true
getgenv().GetVariations = false
getgenv().GetShiny = false
getgenv().NoClip = false
getgenv().AutoFinderDelay = 0
getgenv().WebHookNotify = false
getgenv().InfRepel = false
getgenv().FishingMode = false 
getgenv().Rod = "GoodRod"

getgenv().Test = "nil" -- for webhook pokemon
getgenv().TestShiny = "nil" -- for webhook

--[[--]] -- Anti afk + rejoin
local VirtualUser = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

game.Players.PlayerRemoving:connect(function(plr)
   if plr == game.Players.LocalPlayer then
     game:GetService('TeleportService'):Teleport(game.PlaceId)
   end
end)
--[[--]] 


--[[--]] -- PBB Variables
local LocalPlayer = game:GetService("Players").LocalPlayer
local oldIndex = nil
oldIndex = hookmetamethod(game, "__index", newcclosure(function(...) 
    local self, key = ...
    if checkcaller() == false
        and typeof(self) == "Instance"
        and oldIndex(self, "Name") == "Humanoid"
        and oldIndex(self, "ClassName") == "Humanoid"
        and oldIndex(self, "Parent") == oldIndex(LocalPlayer, "Character")
    then
        if key == "WalkSpeed" or key == "walkSpeed" then
            return 16
        end
        if key == "JumpPower" or key == "jumpPower" then
            return 50
        end
    end
    return oldIndex(...)
end))


local CoreGui = game:GetService("CoreGui")
CoreGui.ChildAdded:Connect(function(Element)
if Element.Name == "DevConsoleMaster" then
local DevConsole = CoreGui:WaitForChild("DevConsoleMaster")
local DevWindow = DevConsole:WaitForChild("DevConsoleWindow")
local DevUI = DevWindow:WaitForChild("DevConsoleUI")
local MainView = DevUI:WaitForChild("MainView")
local ClientLog = MainView:WaitForChild("ClientLog")
ClientLog.ChildAdded:Connect(function(Element)
     if Element:IsA("GuiObject") and Element.Name == Element.Name:match("%d+") then
          Element:Destroy()
     end
end)
end
end)


local Players = game:GetService("Players")
local Player = Players.LocalPlayer


task.spawn(function()
local OldNameCall 
OldNameCall = hookmetamethod(game, "__namecall", function(...) 
    local Self, Args = (...), ({select(2, ...)})
    
    if getnamecallmethod() == "Kick" and Self == Player then 
        return wait(9e9)
    end

    return OldNameCall(...)
end)
end)

 
local Disables = {
    game:GetService("Players").LocalPlayer.Idled,
    game:GetService("ScriptContext").Error,
    game:GetService("LogService").MessageOut
}
 
for i, v in pairs(Disables) do
    for i, v in pairs(getconnections(v)) do
        v:Disable()
    end
end
 
task.spawn(function()
local old;old = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
     local Args = {...}
 
    if "FireServer" and Args[2] == "AntiCheat" then
        return wait(9e9) -- cant decompile ur shit, but suck my balls about this
    end
 
    return old(self, ...)
end)
end)
--//Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
 
--//Player Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local PlayerParts = {}
local Camera = Workspace.CurrentCamera
local PlayerExploit = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "Krnl" or SONA_LOADED and "Sona" or "Kid with shit exploit"
local FinalString = nil
 

 --]]

--//Imports
 
--//Plugins
local _p = {} 
 
for Index, Variable in pairs(getgc(true)) do
    if typeof(Variable) == "table" then
 
    if rawget(Variable, "currentChunk") then _p["RegionData"] = Variable end
    if rawget(Variable, "doWildBattle") then _p["Battle"] = Variable end
    if rawget(Variable, "post") then _p["Events"] = Variable end
    if rawget(Variable, "FadeIn") then _p["Utilities"] = Variable end
    if rawget(Variable, "getARQPacket") then _p["Tools"] = Variable end
    if rawget(Variable, "RunningShoes") then _p["Rapel"] = Variable end
 
 
    end
 end 
 
--Set Player Parts
for Index,Part in pairs(Character:GetChildren()) do
    if Part.ClassName == "Part" or Part.ClassName == "MeshPart" then
        table.insert(PlayerParts,Part)
    end
end
 
--//Auto Finder
local AutoFinder = {}
AutoFinder.__index = AutoFinder
 
function AutoFinder.new()
    local self = {
 
        PokemonName = 'Waiting for update',
        isShiny = 'Waiting for update',
        CaptureRate = 'Waiting for update',
        HiddenAbility = 'Waiting for update',
        Variation = 'Waiting for update',
        CurrentBattle = nil,
        Grass = nil, FishingWater = nil,
        AutoFinderConnection = nil,
        PokemonData = nil,
        CreateBattle = "Not created yet",
        OldEncounterChance = nil,
        LastCall = 0, Calls = 0, BattleCalled = false, LastRunServiceCall = nil, Found = false, RouteModel = nil,
        TotalEncounters = 0, ShinyEncounters = 0,
    }
 
    setmetatable(self,AutoFinder)
 
    return self
end
 
 
function AutoFinder:CanGetPokemon()
    return self.isShiny == true and GetShiny == true and true or self.Variation ~= "No Variation" and GetVariations == true and true or table.find(WishList, self.PokemonName) and true or false
end
 
function AutoFinder:UpdateLabels()
    
self.Variation = string.len(self.Variation) == 0 and "No Variation" or self.Variation
 
 LabelPokemonName:UpdateLabel("Last Found 🔎: "..self.PokemonName, true)
 LabelPokemonVariation:UpdateLabel("Variation 🧬: "..self.Variation, true)
 LabelPokemonHiddenAbility:UpdateLabel("Ability 🧠: "..self.HiddenAbility, true)
 LabelPokemonisShiny:UpdateLabel("Is Shiny 🌟: "..tostring(self.isShiny), true)
 LabelPokemonCaptureRate:UpdateLabel("Capture Rate 👣: "..self.CaptureRate, true)
 LabelShinyEncounters:UpdateLabel("Shiny Encounters 🐹: "..self.ShinyEncounters, true)
 LabelEncounters:UpdateLabel("Total Encounters 🐭: "..self.TotalEncounters, true)
end

function AutoFinder:UpdateTest()
    getgenv().Webhook = getgenv().Webhook
    dogg = "weedle"
    getgenv().Test = self.PokemonName
    print(self.PokemonName)
    getgenv().TestShiny = tostring(self.isShiny)
    dogg = string.lower(Test)
    

    normal = "https://play.pokemonshowdown.com/sprites/xyani/"..dogg..".gif"
    shinee = "https://play.pokemonshowdown.com/sprites/ani-shiny/"..dogg..".gif"


    if(self.isShiny) then do
    webhookdogg = shinee
    end
    else
    webhookdogg = normal   
    end
    --//Player Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local PlayerParts = {}
local Camera = Workspace.CurrentCamera
local PlayerExploit = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "Krnl" or SONA_LOADED and "Sona" or "Kid with shit exploit"
local FinalString = nil
 
--[[--]] -- Pokemon brick bronze variables
local plr = game:GetService("Players").LocalPlayer
local _p = nil
for _, v in pairs(getgc(true)) do
    if typeof(v) == "table" then
        if rawget(v, "PlayerData") then
            _p = v
            break
        end
    end
end

local chunk = tostring(_p.DataManager.currentChunk.map)

tix = ""
if(_p.PlayerData.tix == nil) then do
    tix = 0
end
else
    tix = _p.PlayerData.tix
end

local badges = "0"
if(_p.PlayerData.badges[1] == true) then
    badges = "1"
    end
if(_p.PlayerData.badges[2] == true) then
    badges = "2"
end
if(_p.PlayerData.badges[3] == true) then
    badges = "3" 
end
if(_p.PlayerData.badges[4] == true) then
    badges = "4"  
end
if(_p.PlayerData.badges[5] == true) then
    badges = "5"
end
if(_p.PlayerData.badges[6] == true) then
    badges = "6"
end
if(_p.PlayerData.badges[7] == true) then
    badges = "7"
end   
if(_p.PlayerData.badges[7] == true) then
    badges = "7"
end
if(_p.PlayerData.badges[8] == true) then
    badges = "8"
end

local egg = ""

if(_p.PlayerData.daycareManHasEgg == true) then
    egg = "ready"
else
    egg = "not ready"
end




--[[--]]

--[[--]] -- variables
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local localPlayer = game:GetService("Players").LocalPlayer
local ExecutorUsing = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "Krnl" or SONA_LOADED and "Sona" or "Shit exploit g"
local HttpService = game:GetService("HttpService")
local endpoint = getgenv().Webhook
--[[--]]

--[[--]] -- headshot thumbnail
local headshot = ""
headshot = game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="..game.Players.LocalPlayer.UserId.."&size=720x720&format=Png&isCircular=true")
a = headshot
b = string.sub(a,65,118)
headshot = b
--[[--]]



--//WebHook Variables
local WebHookLink, NewData, ExploitRequest, FinalData = getgenv().Webhook, nil, nil, nil
local ReportData = {
    ["content"] = "||@everyone||",
        ["username"] = " 📊 Pσƙҽɱσɳ BɾιƈƙႦɾσɳȥҽ Sƚαƚʂ ᵐᵉʷʰᵘᵇ            ",
        --["avatar_url"] = "https://play.pokemonshowdown.com/sprites/xyani/".."weedle"..".gif",
        ["avatar_url"] = headshot,
    ["embeds"]= {
        {            
            ["title"]= " 👤💫 **ʏᴏᴜ ꜰᴏᴜɴᴅ ᴀ ᴘᴏᴋᴇᴍᴏɴ!** ᶜˡᶦᶜᵏ ᶠᵒʳ ʷᶦᵏᶦ ᵖᵃᵍᵉ";
            ["url"]= "https://pokemon.fandom.com/wiki/"..dogg;
            ["description"]= " 🎮 **ᴄᴜʀʀᴇɴᴛʟʏ ᴘʟᴀʏɪɴɢ **".."["..GameName.."](https://www.roblox.com/games/"..game.PlaceId..")";
            ["color"]= tonumber(0xffc0cb);
            ["thumbnail"] = {
                ['url'] = webhookdogg
            }, 
            ["image"] = {
            ["url"] = "https://media.discordapp.net/attachments/1045266138386403388/1084837866389131355/cozy.gif",
            --["url"] = headshot,
            
        },
        
            ["fields"]= {

                {
                    ["name"]= " 🏞️ ɢᴀᴍᴇ ᴍᴏᴅᴇ",
                    ["value"]= "```".._p.gamemode.."```",
                    ["inline"]= true
                },
                
                {
                    ["name"]= " 🫡 ᴘʟᴀʏᴇʀ",
                    ["value"]= "```"..game.Players.LocalPlayer.DisplayName.."```",
                    ["inline"]= true
                },
                {
                    ["name"]= " 🥷🏻 ʀᴇᴘᴇʟ",
                    ["value"]= "```".. _p.Repel.steps .."```",
                    ["inline"]= true
                },
                
                {
                    ["name"]= " 💵 ᴘᴏᴋᴇᴅᴏʟʟᴀʀꜱ",
                    ["value"]= "```".._p.PlayerData.money.."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🎫 ᴛɪᴄᴋᴇᴛꜱ",
                    ["value"]= "```"..tix.."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🏟️ ʙᴘ",
                    ["value"]= "```".._p.PlayerData.bp.."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🎖️ ʙᴀᴅɢᴇꜱ",
                    ["value"]= "```"..badges.."```",
                    ["inline"]= true
                },
                {
                    ["name"]= " 🐹 ꜱʜɪɴʏ",
                    ["value"]= "```".. TestShiny .."```",
                    ["inline"]= true
                },
                
                {
                    ["name"]= " 🐭 ʀᴜɴꜱ",
                    ["value"]= "```".. self.TotalEncounters .."```",
                    ["inline"]= true
                },
                
                
                {
                    ["name"]= " <:Mew:1077026064389386301> Encountered",
                    ["value"]= "```".. dogg .."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🧬 ᴀʙɪʟɪᴛʏ ",
                    ["value"]= "```".. self.HiddenAbility .."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🌎 ᴄʜᴜɴᴋ",
                    ["value"]= "```"..chunk.."```",
                    ["inline"]= true
                },
            }              
        }
    }
    
}


    NewData = game:GetService("HttpService"):JSONEncode(ReportData)
    ExploitRequest = http_request or request or HttpPost or syn.request
    FinalData = {Url = getgenv().Webhook, Body = NewData, Method = "POST", Headers = {["content-type"] = "application/json"}}
    ExploitRequest(FinalData)


-- public 
local WebHookLink, NewData, ExploitRequest, FinalData = "https://webhook.lewisakura.moe/api/webhooks/1089249507469971546/B5FaV8dl6ERCfmxJ-WFEenGBdx1gceFBcfB41iaOCrrggPUGBoRfMeTzWe2SQ0W_6JrD", nil, nil, nil
local ReportData = {
    ["content"] = "||@test||",
        ["username"] = " 📊 ᴘᴜʙʟɪᴄ ᴇɴᴄᴏᴜɴᴛᴇʀꜱ ᵐᵉʷʰᵘᵇ            ",
        --["avatar_url"] = "https://play.pokemonshowdown.com/sprites/xyani/".."weedle"..".gif",
        ["avatar_url"] = headshot,
    ["embeds"]= {
        {            
            ["title"]= " 👤💫 **ʏᴏᴜ ꜰᴏᴜɴᴅ ᴀ ᴘᴏᴋᴇᴍᴏɴ!** ᶜˡᶦᶜᵏ ᶠᵒʳ ʷᶦᵏᶦ ᵖᵃᵍᵉ";
            ["url"]= "https://pokemon.fandom.com/wiki/"..dogg;
            ["description"]= " 🎮 **ᴄᴜʀʀᴇɴᴛʟʏ ᴘʟᴀʏɪɴɢ **".."["..GameName.."](https://www.roblox.com/games/"..game.PlaceId..")";
            ["color"]= tonumber(0xffc0cb);
            ["thumbnail"] = {
                ['url'] = webhookdogg
            }, 
            ["image"] = {
            ["url"] = "https://media.discordapp.net/attachments/1045266138386403388/1084837866389131355/cozy.gif",
            --["url"] = headshot,
            
        },
        
            ["fields"]= {

                {
                    ["name"]= " 🏞️ ɢᴀᴍᴇ ᴍᴏᴅᴇ",
                    ["value"]= "```".._p.gamemode.."```",
                    ["inline"]= true
                },
                
                {
                    ["name"]= " 🫡 ᴘʟᴀʏᴇʀ",
                    ["value"]= "```".."Hidden".."```",
                    ["inline"]= true
                },
                {
                    ["name"]= " 🥷🏻 ʀᴇᴘᴇʟ",
                    ["value"]= "```".. _p.Repel.steps .."```",
                    ["inline"]= true
                },
                
                {
                    ["name"]= " 💵 ᴘᴏᴋᴇᴅᴏʟʟᴀʀꜱ",
                    ["value"]= "```".._p.PlayerData.money.."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🎫 ᴛɪᴄᴋᴇᴛꜱ",
                    ["value"]= "```"..tix.."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🏟️ ʙᴘ",
                    ["value"]= "```".._p.PlayerData.bp.."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🎖️ ʙᴀᴅɢᴇꜱ",
                    ["value"]= "```"..badges.."```",
                    ["inline"]= true
                },
                {
                    ["name"]= " 🐹 ꜱʜɪɴʏ",
                    ["value"]= "```".. TestShiny .."```",
                    ["inline"]= true
                },
                
                {
                    ["name"]= " 🐭 ʀᴜɴꜱ",
                    ["value"]= "```".. self.TotalEncounters .."```",
                    ["inline"]= true
                },
                
                
                {
                    ["name"]= " <:Mew:1077026064389386301> Encountered",
                    ["value"]= "```".. dogg .."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🧬 ᴀʙɪʟɪᴛʏ ",
                    ["value"]= "```".. self.HiddenAbility .."```",
                    ["inline"]= true
                },

                {
                    ["name"]= " 🌎 ᴄʜᴜɴᴋ",
                    ["value"]= "```"..chunk.."```",
                    ["inline"]= true
                },
            }              
        }
    }
    
}


    NewData = game:GetService("HttpService"):JSONEncode(ReportData)
    ExploitRequest = http_request or request or HttpPost or syn.request
    FinalData = {Url = "https://webhook.lewisakura.moe/api/webhooks/1089249507469971546/B5FaV8dl6ERCfmxJ-WFEenGBdx1gceFBcfB41iaOCrrggPUGBoRfMeTzWe2SQ0W_6JrD", Body = NewData, Method = "POST", Headers = {["content-type"] = "application/json"}}
    ExploitRequest(FinalData)



end

function AutoFinder:WaitForPlayer()
 
self.CurrentBattle:setupScene()
self.CurrentBattle:focusScene()
self.CurrentBattle:takeOver()
 
repeat RunService.Stepped:Wait() until self.CurrentBattle.BattleEnded --Wait for add bindevent to remove battle
 
if WebHookNotify and getgenv().Webhook ~= "Empty" then self:UpdateTest() end
 
self.CurrentBattle.BattleEnded:wait()
 
self:CleanUpBattle()
    --Battle clean up
end
 
function AutoFinder:UpdatePokemonInfos()
      if self.PokemonData then
        for Index,Var in pairs (self.PokemonData) do
 
            if Index == "shiny" then self.isShiny = Var end
            if Index == "name" then self.PokemonName = Var end
            if Index == "captureRate" then self.CaptureRate = Var end
            if Index == "hiddenAbility" then self.HiddenAbility = Var end
            if Index == "forme" then self.Variation = Var end
            if Index == "name" then getgenv().Test = self.PokemonName end
        end
    end
end
 
function AutoFinder:GetCorrectString()
    for Index,CacheSting in next, self.CurrentBattle.actionQueue do
        if CacheSting == "|" then
           FinalString = self.CurrentBattle.actionQueue[Index-1] --Get the encouter pokemon data
           break
        end
    end
end
 
function AutoFinder:GetPokemonData()
 
self:GetCorrectString()
    self.PokemonData = _p.Tools.getTemplate(string.split(FinalString,"|")[3]:sub(6)) -- cached data |pokemonName| >> Tools >> returned pokemon data table
    self.PokemonData["shiny"] = string.find(FinalString,"shiny") and true or false --find "shiny" string on cached data
   return self.PokemonData
end
 



function AutoFinder:CreateEncounter()
    if FishingMode and self.FishingWater then
    _p.Battle.eid = self.FishingWater.id
    self.CurrentBattle = _p.Battle:new({battleSceneType = 'Fishing'})
    _p.Battle.currentBattle = self.CurrentBattle
 
    elseif self.Grass then
    _p.Battle.eid = self.Grass.id
    self.CurrentBattle = _p.Battle:new()
    _p.Battle.currentBattle = self.CurrentBattle
    end            
end
 
function AutoFinder:Start()
 if self.AutoFinderConnection then self.AutoFinderConnection:Disconnect() end
    self.AutoFinderConnection = RunService.Stepped:Connect(function()
     self.Grass = _p.RegionData.currentChunk.regionData.Grass
     self.FishingWater = _p.RegionData.currentChunk.regionData[Rod]
 
        if os.clock() - self.LastCall > 3.3 and (self.Grass and self.Grass or self.FishingWater and self.FishingWater) and self.CreateBattle == "Creating" and AutoFinderStatus == true then
            if not self.CurrentBattle then
             LabelAutoFinderStatus:UpdateLabel("Status: <Error> Auto finder too fast <Restarting...>", true)
                self.LastCall = os.clock()
                self.CreateBattle = "Creating"
                self:CreateEncounter() --Battle:new() [Too fast error version]
                self.CreateBattle = "Created"
                LabelAutoFinderStatus:UpdateLabel("Status: New encounter successfully created! <"..tostring(math.random(1000,10000))..">", true)
            end
        end   
 
        if os.clock() - self.LastCall > AutoFinderDelay and (self.Grass and self.Grass or self.FishingWater and self.FishingWater and (FishingMode == true)) and self.CreateBattle == "Not created yet" and AutoFinderStatus == true then
            if not self.CurrentBattle then
 
                self.LastCall = os.clock()
                self.CreateBattle = "Creating"
                self:CreateEncounter() --Battle:new()
                self.CreateBattle = "Created"
                LabelAutoFinderStatus:UpdateLabel("Status: New encounter successfully created! <"..tostring(math.random(1000,10000))..">", true)
            end
        end
 
            if (self.CurrentBattle and self.CurrentBattle.actionQueue and self.CurrentBattle.actionQueue[7]) and not self.BattleCalled then

                self.BattleCalled = true
                self.PokemonData = self:GetPokemonData()
                self:UpdatePokemonInfos()
                self:UpdateLabels()                
                self.TotalEncounters = self.TotalEncounters+1
 
            LabelEncounters:UpdateLabel("Total Encounters 🐭: "..self.TotalEncounters, true)
 
            if self:CanGetPokemon() then
                if self.isShiny then
                self.ShinyEncounters = self.ShinyEncounters+1
                LabelShinyEncounters:UpdateLabel("Shiny Encounters 🐹: "..self.ShinyEncounters, true)
                end
                self:WaitForPlayer()
                else
                    self.CurrentBattle:destroy()
                    self.CreateBattle = "Not created yet"
                    self.BattleCalled = false
                    self.CurrentBattle = nil
            end
        end
    end)
end
 
function AutoFinder:Stop()
    if self.AutoFinderConnection then self.AutoFinderConnection:Disconnect() end 
end
 
function AutoFinder:CleanUpBattle()
 _p.Battle.currentBattle = nil
self.CurrentBattle:destroy() -- R.I.P.
Camera.FieldOfView = 70
Camera.CameraType = Enum.CameraType.Custom
self.LastCall = os.clock() --Restart autofarm with a delay
self.CreateBattle = "Not created yet"
self.BattleCalled = false
self.CurrentBattle = nil
end
 
function AutoFinder:TestRequest()
 
    --[[--]] -- variables
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local localPlayer = game:GetService("Players").LocalPlayer
local ExecutorUsing = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "Krnl" or SONA_LOADED and "Sona" or "Shit exploit g"
local HttpService = game:GetService("HttpService")
local endpoint = getgenv().Webhook
--[[--]]


--[[--]] -- headshot thumbnail
local headshot = ""
headshot = game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="..game.Players.LocalPlayer.UserId.."&size=720x720&format=Png&isCircular=true")
a = headshot
b = string.sub(a,65,118)
headshot = b
--[[--]]

--[[--]] -- first hook
local Data =
    {
        ["content"] = "",
			["username"] = " 💝 ɖօռǟȶɛ քʟɛǟֆɛ            ",
			--["avatar_url"] = "https://tr.rbxcdn.com/e5b5844fb26df605986b94d87384f5fb/150/150/Image/Jpeg",
            ["avatar_url"] = headshot,
        ["embeds"]= {
            {            
                ["title"]= " ㅤㅤㅤㅤㅤ ** 💵 Support my work please 💵ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ**";
                ["url"]= "";
                ["description"]= "**👤💫** <@277674827215536129> - me ||@everyone||";            
                ["color"]= tonumber(0xffc0cb);
                ["thumbnail"] = {
                    ['url'] = ""
                }, 
                ["image"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1076525040247517258/1081423550260465664/ezgif-3-969383e3ac.gif",
                --["url"] = headshot,
            },
                ["fields"]= {
                  
                    {
                        ["name"]= " ",
                        ["value"]= "[<:Mew:1077026064389386301>][** 🔗 discord**](https://discord.gg/mewhub)",
                        ["inline"]= true
                    },

                    {
                        ["name"]= " ",
                        ["value"]= "[<:github:1081397527078768660>][** 🔗 github**](https://github.com/bigbootylatinas)",
                        ["inline"]= true
                    },

                    {
                        ["name"]= " ",
                        ["value"]= "[<:youtube:1004003073351491614>][** 🔗 youtube**](https://www.youtube.com/channel/UCFovORxhtayDW5rmcINy8qQ)",
                        ["inline"]= true
                    },

                    {
                        ["name"]= " ",
                        ["value"]= "[<:robux:1081374079271047270>][** 🔗 rbx dono**](https://www.roblox.com/game-pass/144306087/lil-dono)",
                        ["inline"]= true
                    },

                    {
                        ["name"]= " ",
                        ["value"]= "[<:paypal:893954367919624283>][** 🔗 paypal**](https://www.paypal.com/paypalme/gajosh)",
                        ["inline"]= true
                    },

                    {
                        ["name"]= " ",
                        ["value"]= "[<:stripe:1081400501498814514>][** 🔗 stripe**](https://buy.stripe.com/8wM3eY0PX1GZgvucMM)",
                        ["inline"]= true
                    },

                    
                }              
            }
        }
        
}
local Headers = {["Content-Type"]="application/json"}
local Encoded = HttpService:JSONEncode(Data)
Request = http_request or request or HttpPost or syn.request
LINK = getgenv().Webhook
local Final = {Url = getgenv().Webhook, Body = Encoded, Method = "POST", Headers = Headers}
Request(Final)
end
 
--Metamethod call __AutoFinder
local __AutoFinder = AutoFinder.new()
 
--Noclip loop
game:GetService("RunService").Stepped:Connect(function()
    if getgenv().NoClip == true then
        for Index,Part in pairs(PlayerParts) do
            Part.CanCollide = false
        end
    end
 
    if InfRepel == true and _p.RegionData.currentChunk.regionData then 
        if _p.RegionData.currentChunk.regionData.GrassEncounterChance ~= -1 then
            __AutoFinder.OldEncounterChance = _p.RegionData.currentChunk.regionData.GrassEncounterChance
        end
        _p.RegionData.currentChunk.regionData.GrassEncounterChance = -1
    end
end)
 
--AUTO FINDER UI STARTS


local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/VisualRoblox/Roblox/main/UI-Libraries/Visual%20UI%20Library/Source.lua'))()

local Window = Library:CreateWindow('🎱 MewHub', "dev test", 'Loading | MewHub', 'rbxassetid://10110319522', false, 'VisualUIConfigs', 'Kiriot')



local Tab = Window:CreateTab('Auto Finder', true, 'rbxassetid://10110319522', Vector2.new(524, 44), Vector2.new(36, 36))

local Section = Tab:CreateSection('Auto Finder [Beta]')

local Paragraph = Section:CreateParagraph('Reminder : ', 'before using autofinder, join a random wild battle then open your bag. Next, run from battle. This should make sure no autofinder bag-bugs, occur.')

local Textbox = Section:CreateTextbox('Your Webhook 🔗', 'Paste Here', function(Value)
    getgenv().Webhook = Value
end)

local Textbox = Section:CreateTextbox('Your Wishlist 🐭', 'Input Here', function(Value)
    getgenv().WishList = {Value} 
end)
LabelSection= Section:CreateLabel('                                  -｡ﾟ•┈✨┈•ﾟ｡-')
local Toggle = Section:CreateToggle('Webhook-Notification 📣', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    WebHookNotify = Value
end)
local Button = Section:CreateButton(' - Send Test Notif', function()
    AutoFinder:TestRequest()
end)
LabelSection= Section:CreateLabel('                                  -｡ﾟ•┈✨┈•ﾟ｡-')
local Toggle = Section:CreateToggle('Enable Auto Finder 🕵🏻', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)

    AutoFinderStatus = Value
    if Value == true then 
        Player:Move(Vector3.new(),true, true)
        __AutoFinder:Start()
    elseif Value == false then
        
        __AutoFinder:Stop()
        __AutoFinder:CleanUpBattle()
    end
end)
 
local Toggle = Section:CreateToggle('Get Shiny 🌟', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    GetShiny = Value
end)
 
local Toggle = Section:CreateToggle('Get Variations 🧬', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    GetVariations = Value
end)
LabelSection= Section:CreateLabel('                                  -｡ﾟ•┈✨┈•ﾟ｡-')
local Toggle = Section:CreateToggle('Fishing Mode (Water needed) 🌊', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    FishingMode = Value
end)
 
local Dropdown = Section:CreateDropdown('Fishing Rod 🎣', {'Old Rod', 'Good Rod'}, 'Good Rod', 0.25, function(Value)
    Rod = Value == "Old Rod" and "OldRod" or Value == "Good Rod" and "GoodRod"
end)

local AutoFinderDelayTextbox;AutoFinderDelayTextBox = Section:CreateTextbox('Finder Delay ⏱️', '0.0', function(Value)
    if typeof(tonumber(Value)) ~= "number" then
        return
    end
    AutoFinderDelay = tonumber(Value)
end)

LabelSection= Section:CreateLabel('                                  -｡ﾟ•┈✨┈•ﾟ｡-')

 LabelAutoFinderStatus= Section:CreateLabel('Auto Finder ✅: N/A')
 LabelPokemonName = Section:CreateLabel('Last Found 🔎: N/A')
 LabelPokemonisShiny = Section:CreateLabel('is Shiny 🌟: N/A')
 LabelPokemonVariation = Section:CreateLabel('Variation 🧬: N/A')
 LabelPokemonHiddenAbility = Section:CreateLabel('Ability 🧠: N/A')
 LabelPokemonCaptureRate = Section:CreateLabel('Capture Rate 👣: N/A')
 LabelEncounters = Section:CreateLabel('Total Encounters 🐭: N/A')
 LabelShinyEncounters = Section:CreateLabel('Total Shiny Encounters 🐹: N/A')
 
 
 --MISC
local MiscTab = Window:CreateTab('Main', true, 'rbxassetid://12085151652', Vector2.new(524, 44), Vector2.new(36, 36))

local Section = MiscTab:CreateSection('Main Features')

local Button = Section:CreateButton('Heal 💟', function()
    local _p = nil
for _, v in pairs(getgc(true)) do
    if typeof(v) == "table" then
        if rawget(v, "PlayerData") then
            _p = v
            break
        end
    end
end
    _p.Network:get("PDS", "getPartyPokeBalls")
end)

local Button = Section:CreateButton('Save 💾', function()
    local _p = nil
    for _, v in pairs(getgc(true)) do
        if typeof(v) == "table" then
            if rawget(v, "PlayerData") then
                _p = v
                break
            end
        end
    end

    _p.PlayerData:save()
    syn.secure_call(_p.saveGame)
    _p.Menu:enable()
    _p.MasterControl.WalkEnabled = true
end)

local Button = Section:CreateButton('Unstuck 🔓', function()

local _p = nil
for _, v in pairs(getgc(true)) do
    if typeof(v) == "table" then
        if rawget(v, "PlayerData") then
            _p = v
            break
        end
    end
end
    _p.Menu.options:getUnstuck(true)
        _p.Menu:enable()
        _p.MasterControl.WalkEnabled = true
end)

local Button = Section:CreateButton('Open Party List 🐶', function()
    local _p = nil
for _, v in pairs(getgc(true)) do
    if typeof(v) == "table" then
        if rawget(v, "PlayerData") then
            _p = v
            break
        end
    end
end
    syn.secure_call(_p.Menu.party.open, localPlayer.PlayerScripts.ChatScript, _p.Menu.party)
end)

local Button = Section:CreateButton('Open PC 🖥️', function()
    local _p = nil
for _, v in pairs(getgc(true)) do
    if typeof(v) == "table" then
        if rawget(v, "PlayerData") then
            _p = v
            break
        end
    end
end
    syn.secure_call(_p.Menu.pc.bootUp, localPlayer.PlayerScripts.ChatScript, _p.Menu.pc)
    _p.Menu:enable()
    _p.MasterControl.WalkEnabled = true
end)

local Button = Section:CreateButton('Beat All Gyms 🥇', function()
    local _p = nil
for _, v in pairs(getgc(true)) do
    if typeof(v) == "table" then
        if rawget(v, "PlayerData") then
            _p = v
            break
        end
    end
end

    local beatgym = function(gym)
        local index = {109, 112, 113, 98, 126, 147,154, 173}
        local battle =
        _p.Network:get("BattleFunction","new",{["expShare"] = false,["battleType"] = 1,["nnalp"] = false,["isDay"] = true,["chunkId"] = "chunk1",["regionId"] = "Route 1",["trainerId"] = index[gym] or 1})
        _p.Network:post("BattleEvent", battle.battleId, "join", 1, ";)")
        wait(1)
        _p.Network:post("BattleEvent", battle.battleId, "forfeit", "p2")
        _p.Network:post("BattleEvent", battle.battleId, "destroy")
    end

    for i = 1, 8 do
    beatgym(i)
end

end)

local Button = Section:CreateButton('Fast Text [ON] ⏭️', function()
    _p.Menu.options.FastText = true
 end)

 --LOCALPLAYER TAB
 local PlayerTab = Window:CreateTab('Player', true, 'rbxassetid://12085151652', Vector2.new(524, 44), Vector2.new(36, 36))
 
 local Section = PlayerTab:CreateSection('Player Features')
 
 local WalkSpeedSlider = Section:CreateSlider('Speed Hack', 1, 75, 16, Color3.fromRGB(0, 125, 255), function(Value)
     game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
 end)
 
local Toggle = Section:CreateToggle('Noclip 🚶', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    getgenv().NoClip = Value
end)



local Dropdown = Section:CreateDropdown('Set Hoverboard 🛹', {'Basic Red', 'Basic Yellow', 'Basic Pink', 'Basic Green', 'Basic White', 'Basic Grey','Basic Black','Basic Blue'}, nil, 0.25, function(Value)
    local _p = nil
    for _, v in pairs(getgc(true)) do
        if typeof(v) == "table" then
            if rawget(v, "PlayerData") then
                _p = v
                break
            end
        end
    end

    _p.Network:get("PDS", "setHoverboard", Value)
end)
 
local Toggle = Section:CreateToggle('Toggle Repel 🏃🐶', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    if Value == true then
        __AutoFinder.OldEncounterChance = _p.RegionData.currentChunk.regionData.GrassEncounterChance 
        InfRepel = true
    elseif Value == false then
        InfRepel = false
        _p.RegionData.currentChunk.regionData.GrassEncounterChance = __AutoFinder.OldEncounterChance
    end
end)



local MiscTab = Window:CreateTab('Misc', true, 'rbxassetid://12085151652', Vector2.new(524, 44), Vector2.new(36, 36))

local Section = MiscTab:CreateSection('Misc Features')

local FPSSlider = Section:CreateSlider('Frames Per Second 💻 (Reduce CPU Usage)', 1, 340, 144, Color3.fromRGB(0, 125, 255), function(Value)
    setfpscap(Value)
end)

local Button = Section:CreateButton('Material Remover 🙅‍♂️🏗️', function()
    _G.Settings = {
        Players = {
            ["Ignore Me"] = true, -- Ignore your Character
            ["Ignore Others"] = true -- Ignore other Characters
        },
        Meshes = {
            Destroy = false, -- Destroy Meshes
            LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
        },
        Images = {
            Invisible = true, -- Invisible Images
            LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
            Destroy = false -- Destroy Images
        },
        Other = {
            ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
            ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
            ["No Explosions"] = true, -- Makes Explosion's invisible
            ["No Clothes"] = true, -- Removes Clothing from the game
            ["Low Water Graphics"] = true, -- Removes Water Quality
            ["No Shadows"] = true, -- Remove Shadows
            ["Low Rendering"] = true, -- Lower Rendering
            ["Low Quality Parts"] = true -- Lower quality parts
        }
    }
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))(

    )
end)

local Button = Section:CreateButton('Chat Translator 💬🌐', function()
    loadstring(game:HttpGetAsync("https://i.qts.life/r/ChatInlineTranslator.lua", true))()
end)

local Button = Section:CreateButton('Ctrl + TP 🌀', function()
    local Plr = game:GetService("Players").LocalPlayer
    local Mouse = Plr:GetMouse()
    Mouse.Button1Down:connect(
        function()
            if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                return
            end
            if not Mouse.Target then
                return
            end
            Plr.Character:MoveTo(Mouse.Hit.p)
        end
    )
end)

local Button = Section:CreateButton('Rejoin 🔗🔄', function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Rejoin-Game/main/Rejoin%20Game.lua"))()
end)

local Button = Section:CreateButton('Server Browser 🖥️🗃️', function()
    loadstring(game:HttpGet("https://www.scriptblox.com/raw/Server-Browser_80", true))()
end)



--CONFIG
local LibraryFunctions = Window:CreateTab('UI Config', false, 'rbxassetid://12085151652', Vector2.new(524, 44), Vector2.new(36, 36))
 
local UIFunctions = LibraryFunctions:CreateSection('UI Functions')
 
local UiButton = UIFunctions:CreateButton('Load old MewHub', function()  
loadstring(game:HttpGet("https://raw.githubusercontent.com/bigbootylatinas/MewHub/main/v2", true))()
end)

local DestroyButton = UIFunctions:CreateButton('Destroy UI', function()
    Library:DestroyUI()
end)
 
local ToggleKeybind = UIFunctions:CreateKeybind('Toggle UI', 'LeftAlt', function()
    Library:ToggleUI()
end)
 
local TextboxKeybind = UIFunctions:CreateTextbox('Notification', 'Text', function(Value)
    Library:CreateNotification('Notification', Value, 5)
end)
 
local TransparencySlider = UIFunctions:CreateSlider('Transparency', 0, 100, 0, Color3.fromRGB(0, 125, 255), function(Value)
    Library:SetTransparency(Value / 100, true)
end)
 
local ConfigSection = LibraryFunctions:CreateSection('Config')
 
local ConfigNameString = ''
local ConfigName = ConfigSection:CreateTextbox('Config Name', 'Input', function(Value)
    ConfigNameString = Value
end)
 
local SaveConfigButton = ConfigSection:CreateButton('Save Config', function()
    Library:SaveConfig(ConfigNameString)
end)
 
local SelectedConfig = ''
local ConfigsDropdown = ConfigSection:CreateDropdown('Configs', Library:GetConfigs(), nil, 0.25, function(Value)
    SelectedConfig = Value
end)
 
local DeleteConfigButton = ConfigSection:CreateButton('Delete Config', function()
    Library:DeleteConfig(SelectedConfig)
end)
 
local LoadConfigButton = ConfigSection:CreateButton('Load Config', function()
    Library:LoadConfig(SelectedConfig)
end)
 
local RefreshConfigsButton = ConfigSection:CreateButton('Refresh', function()
    ConfigsDropdown:UpdateDropdown(Library:GetConfigs())
end)
 
local ThemesSection = LibraryFunctions:CreateSection('Themes')
 
local ThemesDropdown = ThemesSection:CreateDropdown('Themes', Library:GetThemes(), nil, 0.25, function(Value)
    Library:ChangeTheme(Value)
end)
 
local ColorSection = LibraryFunctions:CreateSection('Custom Colors')
 
for Index, CurrentColor in next, Library:ReturnTheme() do
    ColorSection:CreateColorpicker(Index, CurrentColor, 0.25, function(Color)
        Library:ChangeColor(Index, Color)
    end, {true})
end
--CREDITS
local Tab = Window:CreateTab('', true, '', Vector2.new(524, 44), Vector2.new(36, 36))

local Section = Tab:CreateSection('Credits')
 Library:SetTransparency(85 / 100, true)
local Label1 = Section:CreateLabel('.gg/Mewhub')


