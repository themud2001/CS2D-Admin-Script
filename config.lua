
-- Configurations

themud = {};
_player = {rank={}, mute={}, hat={}};
prefix = "!";
local hatImagePath = "gfx/themud/admin/hats/";

modules = {"vip_system"};

_HATS = {
	[1] = {
		name = "Angel";
		path = hatImagePath.."angel.png";
	};
	
	[2] = {
		name = "Devil";
		path = hatImagePath.."devil.png";
	};
	
	[3] = {
		name = "Gandalf";
		path = hatImagePath.."gandalf_hat.png";
	};
	
	[4] = {
		name = "Pirate";
		path = hatImagePath.."pirate_hat.png";
	};
	
	[5] = {
		name = "Santa";
		path = hatImagePath.."santa_hat.png";
	};

	[6] = {
		name = "Snowman";
		path = hatImagePath.."snowman.png";
	};
};

_RANKS = {
	shorts = {"a", "m", "v", "p"};

	["a"] = {
		name = "Admin";
		prefix = "[Admin]";
		color = "255000020";
	};

	["m"] = {
		name = "Moderator";
		prefix = "[Moderator]";
		color = "010100010";
	};

	["v"] = {
		name = "VIP";
		prefix = "[VIP]";
		color = "255193007";
	};

	["p"] = {
		name = "Player";
		prefix = "";
		color = {
			[0] = "255220000";
			[1] = "255025000";
			[2] = "050150255";
		};
	};	
};

serverMSGS = {
	["error"] = "\169255050030[Error]: \169250250250";
	["success"] = "\169050255050[Server]: \169250250250";
	["info"] = "\169091192222[Server]: \169250250250";
};

_CMDS = {
	[1] = {"kick", "Kicks players", prefix.."kick <id> [<reason>]", ["priv"] = {"admin", "moderator"}};
	[2] = {"ban", "Bans players\' IP", prefix.."ban <id>", ["priv"] = {"admin", "moderator"}};
	[3] = {"tempban", "Temporarily bans players\' IP in minutes", prefix.."tempban <id> <duration>", ["priv"] = {"admin", "moderator"}};
	[4] = {"mute", "Mutes players", prefix.."mute <id>", ["priv"] = {"admin", "moderator"}};
	[5] = {"unmute", "Un-mutes players", prefix.."unmute <id>", ["priv"] = {"admin", "moderator"}};
	[6] = {"slap", "Slaps players", prefix.."slap <id>", ["priv"] = {"admin", "moderator"}};
	[7] = {"rcon", "Uses RCon commands", prefix.."rcon <command>", ["priv"] = {"admin"}};
	[8] = {"hats", "Opens up the hats menu", prefix.."hats", ["priv"] = {"admin", "moderator", "vip"}};
	[9] = {"restart", "Restarts the round", prefix.."restart [<time>]", ["priv"] = {"admin", "moderator"}};
	[10] = {"make", "Promotes/Demotes players", prefix.."make <id> <rank>", ["priv"] = {"admin"}};
	[11] = {"help", "Lists all the commands", prefix.."help", ["priv"] = {"admin", "moderator", "vip"}};
};

for _, scripts in pairs(modules) do
	dofile(script_path().."modules/"..scripts..".lua");
end