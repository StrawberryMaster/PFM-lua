-- PassionFruitMaster (PFM) - now on Lua!
-- @author: StrawberryMaster
-- @version: 1.1.0
-- @date: 2023-01-14
-- @license: MIT
-- @description: A Discord bot written in Lua using the Discordia library.
-- @attributions: Attribution goes to Cherkasy, who made Eridan.
-- @note: run with `luvit pfm.lua` in the command line

local discordia = require('discordia')
local client = discordia.Client()
local commandprefix = "++"
local randomNumber
local rnumcheck = 0

-- Fetch config token
local config = require('config')
local token = config.token

-- Commands here
local fortunes = require('data.fortunes')

-- Print a message to the console when the bot is ready to go
client:on('ready', function()
	local username = client.user.username
	local guilds = #client.guilds
	print(string.format('Ready! Logged in as %s, serving %s servers.', username, guilds))
end)

client:on('messageCreate', function(message)
	local content = message.content
	local command = content:gsub(string.format('^%s', commandprefix), '')

	if not content:match(string.format('^%s', commandprefix)) then
		return
	end

	-- Misc commands
	if command == "ping" then
		local timer = os.clock()
		local embed = {
			title = "Ping",
			description = "Pong! :ping_pong:",
			color = math.random(0x000000, 0xFFFFFF),
			fields = {
				{
					name = "Response time",
					value = string.format("%.2fms", (os.clock() - timer) * 1000)
				},
			}
		}
		message.channel:send({ embed = embed })
	elseif command == "fortune" then
		local fortune = fortunes[math.random(#fortunes)]
		local embed = {
			title = 'Fortune of the day ',
			description = fortune,
			color = math.random(0x000000, 0xFFFFFF),
		}
		message.channel:send({ embed = embed })
	elseif command == "lol" then
		message.channel:send("a")
	elseif command == "god" then
		message.channel:send("Oh god, I'm going to hell!")
		-- Help command
	elseif command == "help" then
		message.channel:send("Current commands: help, lol, number, spam, hyperspam, god, say, textspam, wikipedia, pokemon, hhw, pong, bbb, cease, forum")
		-- External site commands
	elseif command == "wikipedia" then
		message.channel:send("https://en.wikipedia.org/wiki/" .. (content:gsub("++wikipedia ", "")):gsub(" ", "_"))
	elseif command == "pokemon" then
		message.channel:send("https://bulbapedia.bulbagarden.net/wiki/" .. content:gsub("++pokemon ", "") .. "_(Pok%C3%A9mon)")
	elseif command == "hhw" then
		message.channel:send("https://hypotheticalhurricanes.fandom.com/wiki/" .. content:gsub("++hhw ", ""):gsub(" ", "_"))
	elseif command == "forum" then
		message.channel:send("https://hypotheticalhurricanes.fandom.com/wiki/Thread:" .. math.random(1, 135878))
		-- The number game, credits to Cherkasy
	elseif command == "number" then
		rnumcheck = 1
		randomNumber = math.random(0, 100)
		message.channel:send("I'm thinking of a number between my buttocks. Do you know what it is?")
	elseif tonumber(content) and rnumcheck == 1 then
		if tonumber(content) == randomNumber then
			message.channel:send("Correct! The number was " .. randomNumber .. "! ")
		elseif tonumber(content) == 720 then
			message.channel:send("Correct! And that number just so happens to be my credit score, which is between 450 and 850.")
		elseif tonumber(content) == 666 then
			message.channel:send("haha that's the satan number (no)")
		elseif tonumber(content) == 420 then
			message.channel:send("Lol! Tthat's what I call a funny! XD rawr :compression: also no")
		elseif tonumber(content) == 69 then
			message.channel:send("ecks dee! this number reminds me of the hott ladies! owo (youre bad :c)")
		elseif tonumber(content) == 42069 then
			message.channel:send("oh my god... you didn't.. oh my god... oh my god... oh my god... im shaking... oh my god im crying... (yo're goodn't")
		elseif tonumber(content) == 1337 then
			message.channel:send("WHAT A RELEVAN'T MIME! LOL! DO YOU EVER JUST WOMBO COMBO! XD (no)")
		elseif tonumber(content) == 255 then
			message.channel:send("ff s f s fff s ff f f f f f (frick frick sake)")
		elseif tonumber(content) == 65535 then
			message.channel:send("lol, youre go the even far! that's quite prestigious of you, mister!")
		elseif tonumber(content) == 777 then
			message.channel:send("lol!you're a luck-ie! :3) !~$RD \" e dimve")
		elseif tonumber(content) == 8008 then
			message.channel:send("thats a big haha if ive ever seen one")
		elseif tonumber(content) == 80085 then
			message.channel:send("thats a BIGGER haha if ive ever seened one!!!")
		elseif tonumber(content) == 8008135 then
			message.channel:send("THATS AN ABSOLUTELY W I K I D hAHA!! BRO!!! BRO OH BRO OH OH BRO BRO BRO OH OH BRO OH BRO OH")
		elseif tonumber(content) == 413 then
			message.channel:send("big homestuck time! lol, that's right! g \" voskuijL swerkent!")
		elseif tonumber(content) == 612 then
			message.channel:send("biggER homestuck time! lol, the TROL number! you ve got to be fricking me")
		elseif tonumber(content) == 1025 then
			message.channel:send("bigGEST homestuck time! lol, thre EPIC I:TYOl,ite ;;;;;;;;;;;;ent!")
		elseif not tonumber(content) then
			message.channel:send("That's not a number, you sussy baka!")
		else
			message.channel:send("Incorrect! Here's a hint: It happens to be my credit score. :compression:")
		end
		rnumcheck = 0

	elseif command == "shutdown" then
		if message.author.id == "180473421291847690" then
			print("Shutting down the bot...")
			message.channel:send("Shutting down the bot... :compression:")
			client:stop()
		else
			message.channel:send("You do not have permission to shut down the bot, bruh. :rage:")
		end
		client:stop()

	elseif command:match("^log") then
		-- Extract data from command
		local data = command:gsub("^log ", "")
		local userID, punishment, reason, notes = data:match("(%d+) (%S+) (%S+) (%S+)")

		-- Get user's username by ID
		local user = client:getUser(userID)
		user = user and user.username or "Unknown"
		-- Assign moderator's username and ID
		local moderator = message.author.username
		local moderatorID = message.author.id
		-- ++log <user> <moderator> <punishment> <reason> <notes>

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
					value = string.format("%s (ID: %s)", user, userID)
				},
				{
					name = "Moderator",
					value = string.format("%s (ID: %s)", moderator, moderatorID)
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
			color = color,
		}
	
		-- Send embed to log channel
		message.channel:send({ embed = embed })
	end
end)

client:run('Bot ' .. token) 