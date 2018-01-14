
-- Commands functions

function themud.kick(id, _commands)
	if _commands[2] == "" or _commands[2] == " " or _commands[2] == nil then
		msg2(id, serverMSGS["error"].."You must provide a valid ID");
	else
		if player(_commands[2], "exists") then
			if tonumber(_commands[2]) ~= id then
				local reason = "";
				for i=3, #_commands do
					reason = reason.." ".._commands[i];
				end

				msg(serverMSGS["success"].."Player "..player(_commands[2], "name").." has been kicked!");
				parse("kick ".._commands[2].." \""..reason.."\"");
			else
				msg2(id, serverMSGS["error"].."You can\'t kick yourself dude");
			end
		else
			msg2(id, serverMSGS["error"].."You must provide a valid ID");
		end
	end
end

function themud.ban(id, _commands)
	if _commands[2] == nil or _commands[2] == "" or _commands[2] == " " then
		msg2(id, serverMSGS["error"].."You must provide a valid ID");
	else
		if player(_commands[2], "exists") and player(_commands[2], "bot") == false then
			if tonumber(_commands[2]) ~= id then
				local reason = "";
				for i=3, #_commands do
					reason = reason.." ".._commands[i];
				end

				msg(serverMSGS["success"].."Player "..player(_commands[2], "name").." has been banned");
				parse("banip ".._commands[2].." 0 \""..reason.."\"");
			else
				msg2(id, serverMSGS["error"].."You can\'t ban yourself dude");
			end
		else
			msg2(id, serverMSGS["error"].."You must provide a valid ID");
		end
	end
end

function themud.tempban(id, _commands)
	if _commands[2] == nil or _commands[2] == "" or _commands[2] == " " then
		msg2(id, serverMSGS["error"].."You must provide a valid ID");
	else
		if player(_commands[2], "exists") and player(_commands[2], "bot") == false then
			if tonumber(_commands[2]) ~= id then
				if _commands[3] == nil or _commands[3] == "" or _commands[3] == " " then
					msg2(id, serverMSGS["error"].."You must specify valid time");
				else
					msg(serverMSGS["success"].."Player "..player(_commands[2], "name").." has been banned for ".._commands[3].." minutes");
					parse("banip ".._commands[2].." ".._commands[3].." \"Banned for ".._commands[3].." minutes\"");
				end
			else
				msg2(id, serverMSGS["error"].."You can\'t ban yourself dude");
			end
		else
			msg2(id, serverMSGS["error"].."You must provide a valid ID");
		end
	end
end

function themud.mute(id, _commands)
	if _commands[2] == nil or _commands[2] == "" or _commands[2] == " " then
		msg2(id, serverMSGS["error"].."You must provide a valid ID");
	else
		if player(_commands[2], "exists") then
			if tonumber(_commands[2]) ~= id then
				if checkRank(tonumber(_commands[2])) ~= "admin" and checkRank(tonumber(_commands[2])) ~= "moderator" then
					if _player.mute[tonumber(_commands[2])] == false then
						_player.mute[tonumber(_commands[2])] = true;
						msg(serverMSGS["success"].."Player "..player(_commands[2], "name").." has been muted");
					else
						msg2(id, serverMSGS["error"].."The player is already muted");
					end
				else
					msg2(id, serverMSGS["error"].."You can\'t mute a staff member");
				end
			else
				msg2(id, serverMSGS["error"].."You can\'t mute yourself dude");
			end
		else
			msg2(id, serverMSGS["error"].."You must provide a valid ID");
		end
	end
end

function themud.unmute(id, _commands)
	if _commands[2] == nil or _commands[2] == "" or _commands == " " then
		msg2(id, serverMSGS["error"].."You must provide a valid ID");
	else
		if player(_commands[2], "exists") then
			if tonumber(_commands[2]) ~= id then
				if _player.mute[tonumber(_commands[2])] then
					_player.mute[tonumber(_commands[2])] = false;
					msg(serverMSGS["success"].."Player "..player(_commands[2], "name").." has been un-muted");
				else
					msg2(id, serverMSGS["error"].."The player you specified is not even muted");
				end
			else
				msg2(id, serverMSGS["error"].."You can\'t do this on yourself, you are a staff member");
			end
		else
			msg2(id, serverMSGS["error"].."You must provide a valid ID");
		end
	end
end

function themud.slap(id, _commands)
	if _commands[2] == nil or _commands[2] == "" or _commands[2] == " " then
		msg2(id, serverMSGS["error"].."You must provide a valid ID");
	else
		if player(_commands[2], "exists") then
			if tonumber(_commands[2]) ~= id then
				if checkRank(tonumber(_commands[2])) ~= "admin" and checkRank(tonumber(_commands[2])) ~= "moderator" then
					parse("slap ".._commands[2]);
				else
					msg2(id, serverMSGS["error"].."You can\'t use this command on staff members");
				end
			else
				msg2(id, serverMSGS["error"].."You can\'t PSEW PSEW (slap) yourself. Think of it... slap yourself? Nah.");
			end
		else
			msg2(id, serverMSGS["error"].."You must provide a valid ID");
		end
	end
end

function themud.rcon_command(id, _commands)
	if #_commands <= 1 then
		msg2(id, serverMSGS["error"].."You must provide valid console commands");
	else
		local stringOfCommand = "";
		for _, rcon_cmds in pairs(_commands) do
			if _ > 1 then
				stringOfCommand = stringOfCommand.." "..rcon_cmds;
			end
		end

		parse(stringOfCommand);
		msg(serverMSGS["success"].."Player "..player(id, "name").." has executed ".._commands[2]);
	end
end

function themud.hat_command(id, _commands)
	local hats = "";
	for i=1, #_HATS do
		hats = hats..", ".._HATS[i].name;
	end

	menu(id, "Hat menu"..hats);
end

function themud.round_restart(id, _commands)
	local time = _commands[2];
	local phrase = "will restart in";

	if time == "" or time == " " or time == nil then time = 0; phrase = "has been restarted"; end
	parse("restart "..time);
	msg(serverMSGS["success"].."The round "..phrase.." "..time);
end

function themud.make_command(id, _commands)
	if _commands[2] == nil or _commands[2] == "" or _commands == " " then
		msg2(id, serverMSGS["error"].."You must provide a valid ID");
	else
		if player(_commands[2], "exists") then
			if player(_commands[2], "usgn") ~= 0 then
				if tonumber(_commands[2]) ~= id then
					for _, firstLetter in pairs(_RANKS.shorts) do
						if string.lower(_commands[3]:match("^%l")) == firstLetter then
							if string.lower(_commands[3]) == string.lower(_RANKS[firstLetter].name) then
								local file = io.open(script_path().."staff/"..player(_commands[2], "usgn")..".txt", "w");
								file:write(string.lower(_commands[3]));
								file:close();
								_player.rank[_commands[2]] = _commands[3];
								msg(serverMSGS["success"].."Player "..player(_commands[2], "name").." is now ".._commands[3]);
								msg2(_commands[2], serverMSGS["info"].."You are now ".._commands[3]);

								break;
							end
						end
						msg2(id, serverMSGS["error"].."The rank you specified is undefined");
					end
				else
					msg2(id, serverMSGS["error"].."You can\'t use this command on yourself");
				end
			else
				msg2(id, serverMSGS["error"].."The player doesn\'t have an USGN ID");
			end
		else
			msg2(id, serverMSGS["error"].."You must provide a valid ID");
		end
	end
end

function themud.help_command(id, _commands)
	msg2(id, serverMSGS["info"].."The list of the commands: ");

	for i=1, #_CMDS do
		msg2(id, "\169250250250".._CMDS[i][1]..": ".._CMDS[i][2]..". Usage: ".._CMDS[i][3]);
	end
end