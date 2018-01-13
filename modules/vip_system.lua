
function _second()
	 for _, livePlayer in pairs(player(0, "tableliving")) do
	 	if checkRank(livePlayer) ~= "admin" and checkRank(livePlayer) ~= "moderator" and checkRank(livePlayer) ~= "vip" then
	 		if player(livePlayer, "usgn") ~= 0 then
		 		local playerUSGN = player(livePlayer, "usgn");
		 		if stats(playerUSGN, "secs") / 3600 >= 2 then
		 			_player.rank[livePlayer] = "vip";
		 			local file = io.open("sys/lua/themud_admin/staff/"..player(livePlayer, "usgn")..".txt", "w");
		 			file:write(_player.rank[livePlayer]);
		 			file:close();
		 			msg2(livePlayer, serverMSGS["info"].."You are now VIP");
		 		end
	 		end
	 	end
	 end
end

addhook("second", "_second");