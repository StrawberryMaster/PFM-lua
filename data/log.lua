local function logPunishment(message, command)
	-- Extract data from command
	local data = command:gsub("^log ", "")
	local user, moderator, punishment, reason, notes = data:match("(%S+) (%S+) (%S+) (%S+) (%S+) (%S+)")
	
	-- Assign color based on punishment type
	local color
	if punishment == "reminder" then
		color = 0xffa500
	elseif punishment == "warning" then
		color = 0xffff00
	elseif punishment == "final warning" then
		color = 0xff0000
	elseif punishment == "mute" then
		color = 0x0000ff
	elseif punishment == "ban" then
		color = 0x000000
	else
		color = 0xffffff
	end
	
	-- Create embed
	local embed = {
		title = "Punishment Log",
		fields = {
			{
				name = "User",
				value = string.format("%s (ID: %s)", user, message.author.id)
			},
			{
				name = "Moderator",
				value = string.format("%s (ID: %s)", moderator, message.author.id)
			},
			{
				name = "Punishment",
				value = punishment
			},
			{
				name = "Reason",
				value = reason
			},
			{
				name = "Further actions/notes",
				value = notes
			}
		},
		color = color
	}

	-- Send embed to log channel
	local logchannel = client:getChannel("channel_id")
	logchannel:send({ embed = embed })
end

return logPunishment
