
-- The core

function script_path()
	local str = debug.getinfo(2, "S").source:sub(2);
	return str:match("(.*/)");
end

dofile(script_path().."config.lua");

function splitWords(string)
	local temp = {};

	for words in string.gmatch(string, "[^%s]+") do
		table.insert(temp, words);
	end

	return temp;
end

function checkRank(id)
	local path = script_path();
	local file = io.open(path.."staff/"..player(id, "usgn")..".txt", "r");

	if file then
		local rank = file:read();
		return rank;
	else
		return "player";
	end
end

function checkPriv(id, cmdID)
	for _, privilege in pairs(_CMDS[cmdID]["priv"]) do
		if checkRank(id) == privilege then
			return true;
		end
	end

	return false;
end

function _say(id, text)
	local _commands = splitWords(text);
	text = text:gsub("(@C)$", "");

	if _player.mute[id] then
		msg2(id, serverMSGS["error"].."You are muted");
		return 1;
	end
	
	if _commands[1]:sub(0, 1) == prefix then
		if _commands[1]:sub(2) == _CMDS[1][1] then
			if checkPriv(id, 1) then
				themud.kick(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		elseif _commands[1]:sub(2) == _CMDS[2][1] then
			if checkPriv(id, 2) then
				themud.ban(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		elseif _commands[1]:sub(2) == _CMDS[3][1] then
			if checkPriv(id, 3) then
				themud.tempban(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		elseif _commands[1]:sub(2) == _CMDS[4][1] then
			if checkPriv(id, 4) then
				themud.mute(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		elseif _commands[1]:sub(2) == _CMDS[5][1] then
			if checkPriv(id, 5) then
				themud.unmute(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		elseif _commands[1]:sub(2) == _CMDS[6][1] then
			if checkPriv(id, 6) then
				themud.slap(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		elseif _commands[1]:sub(2) == _CMDS[7][1] then
			if checkPriv(id, 7) then
				themud.rcon_command(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		elseif _commands[1]:sub(2) == _CMDS[8][1] then
			if checkPriv(id, 8) then
				themud.hat_command(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		elseif _commands[1]:sub(2) == _CMDS[9][1] then
			if checkPriv(id, 9) then
				themud.round_restart(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		elseif _commands[1]:sub(2) == _CMDS[10][1] then
			if checkPriv(id, 10) then
				themud.make_command(id, _commands);
				return 1;
			else
				msg2(id, serverMSGS["error"].."You are not allowed to use this command");
				return 1;
			end
		end
	end

	if _player.rank[id] == "admin" then
		msg("\169".._RANKS["a"].color.._RANKS["a"].prefix.." "..player(id, "name")..": \169250250250"..text);
		return 1;
	end

	if _player.rank[id] == "moderator" then
		msg("\169".._RANKS["m"].color.._RANKS["m"].prefix.." "..player(id, "name")..": \169250250250"..text);
		return 1;
	end

	if _player.rank[id] == "vip" then
		msg("\169".._RANKS["v"].color.._RANKS["v"].prefix.." "..player(id, "name")..": \169250250250"..text);
		return 1;
	end

	if _player.rank[id] == "player" then
		if _RANKS["p"].prefix == "" then
			msg("\169".._RANKS["p"].color[player(id, "team")].._RANKS["p"].prefix..player(id, "name")..": \169255220000"..text);
			return 1;
		else
			msg("\169".._RANKS["p"].color[player(id, "team")].._RANKS["p"].prefix.." "..player(id, "name")..": \169255220000"..text);
			return 1;
		end
	end
end

function _join(id)
	_player.mute[id] = false;
	_player.rank[id] = string.lower(checkRank(id));

	msg2(id, serverMSGS["info"].."Welcome "..player(id, "name").." to this server");
	msg2(id, serverMSGS["info"].."Your rank is ".._RANKS[_player.rank[id]:match("^%l")].name);
end

function _menu(id, title, button)
	if title == "Hat menu" then
		if (button >= 1 or button < 9) and button ~= 0 then
			if _player.hat[id] then
				freeimage(_player.hat[id]);
				_player.hat[id] = nil;
				_player.hat[id] = image(_HATS[button].path, 1, 0, id+132);
			else
				_player.hat[id] = nil;
				_player.hat[id] = image(_HATS[button].path, 1, 0, id+132);
			end
		end
	end
end

addhook("say", "_say", -99)
addhook("join", "_join", -99)
addhook("menu", "_menu", -99)

dofile(script_path().."commands.lua");