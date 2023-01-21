local function hhw(message)
	local query = message.content:gsub("/hhw ", "")
	local url = "https://hypotheticalhurricanes.fandom.com/wiki/" .. query:gsub(" ", "_")
	message.channel:send(url)
end