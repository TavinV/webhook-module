--[[

Made by Tavin
discord: tavin8149

]]

local Main = {}

local WebhookService = {}
WebhookService.__index = WebhookService

function WebhookService.new(Name,Url)
	local newWebHook = {}
	setmetatable(newWebHook, WebhookService)
	
	newWebHook.Name = Name
	newWebHook.Url = string.gsub(Url, "discord.com", "webhook.lewisakura.moe")
	newWebHook.Backup = string.gsub(Url, "discord.com", "webhook.newstargeted.com")
	return newWebHook
end

--// Services

local HttpService = game:GetService("HttpService")

--// Webhook's native functions 

function BuiltInErrorFunction(WebhookObject, ErrorMessage)
	local ErrorEmbed = Main.Embeds.new(WebhookObject.Name.." fail to post", ErrorMessage, Main.Embeds.Colors.Red)
	
	
	local Result = WebhookObject:Post(ErrorEmbed)
	print(Result)
	if not Result then
		
		warn(WebhookObject.Name.." Faield to post to discord, check the Url. Error message: "..ErrorMessage)
	end
	
end

WebhookService.OnPostError = BuiltInErrorFunction


function WebhookService:Post(Content)
    local finalContent


    if typeof(Content) == "string" then
        local MessageData = {
            ["content"] = Content
        }

        finalContent = HttpService:JSONEncode(MessageData)
    else
        
        finalContent = HttpService:JSONEncode(Content)
    end

    local Url1 = self.Url
    local Url2 = self.Backup

    local PostSucces, ErrorMessage = pcall(function() -- Main URL
        HttpService:PostAsync(Url1, finalContent)
    end)
    if ErrorMessage then
        
        local Post2Succes, ErrorMessage2 = pcall(function() -- Backup URL
            HttpService:PostAsync(Url2, finalContent)

        end)
        if ErrorMessage2 then
            local Post3Succes, ErrorMessage3 = pcall(function() -- Trying to send error message in discord
				WebhookService.OnPostError(self,ErrorMessage2)
				
			end)
           
        end
    end
end

--// Embed Class

local Embeds = {}
Embeds.__index = Embeds

function Embeds.new(title: string, description: string, color: number, content: string)
    local Embed = {}
    
    setmetatable(Embed, Embeds)

    Embed["content"] = content
    Embed["embeds"] = {{}}
    Embed["embeds"][1]["title"] = title
    Embed["embeds"][1]["description"] = description
    Embed["embeds"][1]["color"] =color


    return Embed
end

Embeds.Colors = {
	["Black"] = 0,
	["White"] = 16777215,
	["Red"] = 16711680,
	["Green"] = 65280,
	["Blue"] = 255,
	["Yellow"] = 16776960,
	["Magenta"] = 16711935,
	["Cyan"] = 65535,
	["Gray"] = 8421504,
	["Brown"] = 10824234,
	["Orange"] = 16753920,
	["Pink"] = 16761035,
	["Purple"] = 8388736,
	["Lime"] = 65280,
	["Teal"] = 32896,
	["Aqua"] = 65535,
	["Maroon"] = 8388608,
	["Navy"] = 128,
	["Olive"] = 8421376,
	["Silver"] = 12632256,
	
	
}

function Embeds:AddUrl(url)
    self.embeds[1]["url"] = url
end

function Embeds:AddAuthor(name: string, url: string, icon_url: string)
	
	self.embeds[1]["author"] = {}
	local authorTbl = self.embeds[1]["author"]

	authorTbl["name"] = name
	authorTbl["url"] = url
	authorTbl["icon_url"] = icon_url
end

function Embeds:AddField(name: string, value: string, inline: boolean)
	local fieldsTable

	if not self.embeds[1]["fields"] then
		self.embeds[1]["fields"] = {}
		fieldsTable = self.embeds[1]["fields"]
	else 
		fieldsTable = self.embeds[1]["fields"]
	end

	local newField = {
		["name"] = name,
		["value"] = value,
		["inline"] = inline
	}

	table.insert(fieldsTable, newField)
end

function Embeds:AddThumbnail(thumbnail_url: string)
	self.embeds[1]["thumbnail"] = {["url"] = thumbnail_url}
end

function Embeds:AddImage(image_url: string)
	self.embeds[1]["image"] = {["url"] = image_url}
end

function Embeds:AddFooter(footerText: string, icon_url: string)
	self.embeds[1]["footer"] = {
		["text"] = footerText,
		["icon_url"] = icon_url,
		
	}
end

function Embeds:AddTimestamp(time: string)
	self.embeds[1]["timestamp"] = time
end

Main.WebhookService = WebhookService
Main.Embeds = Embeds

return Main
